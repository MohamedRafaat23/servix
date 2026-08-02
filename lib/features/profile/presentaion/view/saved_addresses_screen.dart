import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  void _removeAddress(int index) {
    context.read<ProfileBloc>().add(DeleteAddressProfileEvent(index));
  }

  void _showAddAddressSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddAddressSheet(
        onSave: (address) {
          context.read<ProfileBloc>().add(AddAddressProfileEvent(address));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Saved Addresses',
          style: TextStyle(
            fontSize: context.responsiveFontScale(18),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
      ),
      body: AppBackground(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final addresses = state.profile?.savedAddresses ?? [];

            return Column(
              children: [
                Expanded(
                  child: addresses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_off_outlined,
                                size: 60.width,
                                color: const Color(0xFFDDE7F0),
                              ),
                              SizedBox(height: 12.height),
                              Text(
                                'No saved addresses',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(15),
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.responsiveHorizontalPadding,
                            vertical: 16.height,
                          ),
                          itemCount: addresses.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.height),
                          itemBuilder: (_, i) => _AddressCard(
                            address: addresses[i],
                            onDelete: () => _removeAddress(i),
                          ),
                        ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 16.height,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.height,
                      child: ElevatedButton(
                        onPressed: _showAddAddressSheet,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightPrimaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.radius),
                          ),
                        ),
                        child: Text(
                          'Add New Address +',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Address Card ──────────────────────────────────────────────────────────────

class _AddressCard extends StatelessWidget {
  final String address;
  final VoidCallback onDelete;

  const _AddressCard({required this.address, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Color(0xFF64B5F6), size: 20),
          SizedBox(width: 10.width),
          Expanded(
            child: Text(
              address,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: const Color(0xFF334155),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// ── Add Address Bottom Sheet ──────────────────────────────────────────────────

class _AddAddressSheet extends StatefulWidget {
  final void Function(String address) onSave;
  const _AddAddressSheet({required this.onSave});

  @override
  State<_AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<_AddAddressSheet> {
  String? _country;
  String? _city;
  final _areaCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _buildingCtrl = TextEditingController();
  final _floorCtrl = TextEditingController();
  final _apartmentCtrl = TextEditingController();

  final List<String> _countries = ['Saudi Arabia', 'Egypt', 'UAE', 'Kuwait', 'Jordan'];
  final List<String> _cities = ['Riyadh', 'Jeddah', 'Mecca', 'Cairo', 'Dubai'];

  @override
  void dispose() {
    _areaCtrl.dispose();
    _streetCtrl.dispose();
    _buildingCtrl.dispose();
    _floorCtrl.dispose();
    _apartmentCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final area = _areaCtrl.text.trim();
    final country = _country ?? '';
    if (area.isEmpty && country.isEmpty) return;
    final address = '${area.isNotEmpty ? area : _city ?? ''} - ${country.isNotEmpty ? country : "Unknown"}';
    widget.onSave(address);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, sc) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: sc,
          padding: EdgeInsets.symmetric(horizontal: 20.width, vertical: 16.height),
          children: [
            Center(
              child: Container(
                width: 40.width,
                height: 4.height,
                margin: EdgeInsets.only(bottom: 16.height),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDE7F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Add New Address',
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.height),
            // Map preview
            Container(
              height: 140.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFE8F4FF),
                border: Border.all(color: const Color(0xFFCDE3F5)),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomPaint(
                      painter: _MapGridPainter(),
                      size: Size.infinite,
                    ),
                  ),
                  const Positioned(
                    top: 50,
                    left: 80,
                    child: Icon(Icons.location_on, color: Color(0xFFEF4444), size: 28),
                  ),
                  Positioned(
                    bottom: 10.height,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 6.height),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 6),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.my_location, color: AppColors.lightPrimaryColor, size: 14.width),
                            SizedBox(width: 5.width),
                            Text('Set Location In Map',
                                style: TextStyle(
                                  color: AppColors.lightPrimaryColor,
                                  fontSize: context.responsiveFontScale(12),
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.height),
            _SheetDropdown(label: 'Country', hint: 'choose country', items: _countries, value: _country, onChanged: (v) => setState(() => _country = v)),
            SizedBox(height: 12.height),
            _SheetDropdown(label: 'City', hint: 'choose city', items: _cities, value: _city, onChanged: (v) => setState(() => _city = v)),
            SizedBox(height: 12.height),
            _SheetInput(label: 'Area', hint: 'write area', controller: _areaCtrl),
            SizedBox(height: 12.height),
            _SheetInput(label: 'Street Name', hint: 'write street', controller: _streetCtrl),
            SizedBox(height: 12.height),
            _SheetInput(label: 'Building Number', hint: 'write building number', controller: _buildingCtrl, keyboardType: TextInputType.number),
            SizedBox(height: 12.height),
            _SheetInput(label: 'Floor Number', hint: 'write floor number', controller: _floorCtrl, keyboardType: TextInputType.number),
            SizedBox(height: 12.height),
            _SheetInput(label: 'Apartment Number', hint: 'write Apartment number', controller: _apartmentCtrl, keyboardType: TextInputType.number),
            SizedBox(height: 20.height),
            SizedBox(
              width: double.infinity,
              height: 52.height,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.radius)),
                ),
                child: Text('Save', style: TextStyle(fontSize: context.responsiveFontScale(16), fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            SizedBox(height: 24.height),
          ],
        ),
      ),
    );
  }
}

class _SheetDropdown extends StatelessWidget {
  final String label, hint;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;

  const _SheetDropdown({required this.label, required this.hint, required this.items, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: context.responsiveFontScale(13), fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
        SizedBox(height: 6.height),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text(hint, style: TextStyle(fontSize: context.responsiveFontScale(13), color: const Color(0xFFB0BEC5))),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFDDE7F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF368CE1))),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: context.responsiveFontScale(13))))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SheetInput extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _SheetInput({required this.label, required this.hint, required this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: context.responsiveFontScale(13), fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
        SizedBox(height: 6.height),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: context.responsiveFontScale(13), color: const Color(0xFFB0BEC5)),
            contentPadding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFDDE7F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF368CE1))),
          ),
        ),
      ],
    );
  }
}

// ── Map Grid Painter ──────────────────────────────────────────────────────────

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBDD9F0).withValues(alpha: .5)
      ..strokeWidth = 0.8;
    const spacing = 18.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final road = Paint()
      ..color = const Color(0xFF93C5FD).withValues(alpha: .7)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, size.height * 0.45), Offset(size.width, size.height * 0.45), road);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
