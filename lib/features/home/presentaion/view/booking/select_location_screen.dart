import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/booking_args.dart';
import 'package:servix/features/home/presentaion/bloc/booking_bloc.dart';
import 'package:servix/features/home/presentaion/bloc/booking_event.dart';
import 'package:servix/features/home/presentaion/bloc/booking_state.dart';
import 'booking_scaffold.dart';
import 'choose_appointment_screen.dart';

// ignore: unused_element

class SelectLocationScreen extends StatelessWidget {
  final BookingArgs args;

  const SelectLocationScreen({super.key, required this.args});

  void _showAddAddressSheet(BuildContext context, ValueSetter<String> onAdd) {
    final bloc = context.read<BookingBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: _AddAddressSheet(onAdd: onAdd),
      ),
    );
  }

  void _onNext(BuildContext context, BookingState state) {
    if (state.addedAddresses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one address')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BookingBloc>(),
          child: ChooseAppointmentScreen(
            args: args.copyWith(selectedAddresses: state.addedAddresses),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(),
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          return _SelectLocationScreenContent(
            state: state,
            onNext: () => _onNext(context, state),
            onShowAddAddressSheet: (onAdd) => _showAddAddressSheet(context, onAdd),
            onAddAddress: (address) => context.read<BookingBloc>().add(BookingAddressAdded(address)),
            onRemoveAddress: (index) => context.read<BookingBloc>().add(BookingAddressRemoved(index)),
          );
        },
      ),
    );
  }
}

class _SelectLocationScreenContent extends StatelessWidget {
  final BookingState state;
  final VoidCallback onNext;
  final ValueChanged<ValueSetter<String>> onShowAddAddressSheet;
  final ValueChanged<String> onAddAddress;
  final ValueChanged<int> onRemoveAddress;

  const _SelectLocationScreenContent({
    required this.state,
    required this.onNext,
    required this.onShowAddAddressSheet,
    required this.onAddAddress,
    required this.onRemoveAddress,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = context.read<BookingBloc>().locationSearchController;

    void showAddAddressSheet() {
      onShowAddAddressSheet((address) {
        onAddAddress(address);
      });
    }

    return BookingScaffold(
      currentStep: 1,
      buttonLabel: 'Next',
      onNext: onNext,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map placeholder
            Container(
              height: 200.height,
              margin: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFE8F4FF),
                border: Border.all(color: const Color(0xFFCDE3F5)),
              ),
              child: Stack(
                children: [
                  // Map background dots pattern
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: const Color(0xFFE8F4FF),
                      child: CustomPaint(
                        painter: _MapGridPainter(),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                  // Fake location pins
                  Positioned(
                    top: 60.height,
                    left: 60.width,
                    child: const Icon(Icons.location_on, color: Color(0xFFEF4444), size: 30),
                  ),
                  Positioned(
                    top: 100.height,
                    right: 80.width,
                    child: const Icon(Icons.location_on, color: Color(0xFFEF4444), size: 30),
                  ),
                  // Set Location button
                  Positioned(
                    bottom: 12.height,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.width,
                            vertical: 8.height,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .08),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.my_location, color: AppColors.lightPrimaryColor, size: 16.width),
                              SizedBox(width: 6.width),
                              Text(
                                'Set Location In Map',
                                style: TextStyle(
                                  color: AppColors.lightPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: context.responsiveFontScale(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Search bar
                  Positioned(
                    top: 12.height,
                    left: 12.width,
                    right: 12.width,
                    child: Container(
                      height: 40.height,
                      padding: EdgeInsets.symmetric(horizontal: 12.width),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .07),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFF94A3B8), size: 18),
                          SizedBox(width: 8.width),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search for an address',
                                hintStyle: TextStyle(
                                  fontSize: context.responsiveFontScale(12),
                                  color: const Color(0xFFB0BEC5),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.height),
            // Added Areas section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Added Areas',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 12.height),
                  ...state.addedAddresses.asMap().entries.map(
                    (entry) => Padding(
                      padding: EdgeInsets.only(bottom: 10.height),
                      child: _AreaChip(
                        address: entry.value,
                        onRemove: () => onRemoveAddress(entry.key),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.height),
                  // Add new address button
                  GestureDetector(
                    onTap: showAddAddressSheet,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.height),
                      decoration: BoxDecoration(
                        color: AppColors.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Add New Address +',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: context.responsiveFontScale(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.height),
          ],
        ),
      ),
    );
  }
}

// ── Area chip ────────────────────────────────────────────────────────────────

class _AreaChip extends StatelessWidget {
  final String address;
  final VoidCallback onRemove;

  const _AreaChip({required this.address, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 10.height),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCDE3F5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Color(0xFF64B5F6), size: 18),
          SizedBox(width: 8.width),
          Expanded(
            child: Text(
              address,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: const Color(0xFF334155),
              ),
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Color(0xFFB0BEC5), size: 18),
          ),
        ],
      ),
    );
  }
}

// ── Add Address Bottom Sheet 

class _AddAddressSheet extends StatelessWidget {
  final void Function(String address) onAdd;

   _AddAddressSheet({required this.onAdd});

  final _formKey = GlobalKey<FormState>();

  final List<String> _countries = ['Saudi Arabia', 'Egypt', 'UAE', 'Kuwait', 'Jordan'];
  final List<String> _cities = ['Riyadh', 'Jeddah', 'Mecca', 'Cairo', 'Dubai'];

  void _submit(BuildContext context, BookingState state) {
    if (_formKey.currentState!.validate()) {
      final area = context.read<BookingBloc>().addressAreaController.text;
      final address = '${area.isNotEmpty ? area : state.addressCity ?? ''} - ${state.addressCountry ?? ''}';
      onAdd(address);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookingBloc>();
    final state = context.watch<BookingBloc>().state;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: 20.width,
                vertical: 16.height,
              ),
              children: [
                // Handle
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
                _DropdownField(
                  label: 'Country',
                  hint: 'choose country',
                  items: _countries,
                  value: state.addressCountry,
                  onChanged: (v) => bloc.add(BookingAddressCountryChanged(v)),
                ),
                SizedBox(height: 14.height),
                _DropdownField(
                  label: 'City',
                  hint: 'choose city',
                  items: _cities,
                  value: state.addressCity,
                  onChanged: (v) => bloc.add(BookingAddressCityChanged(v)),
                ),
                SizedBox(height: 14.height),
                _InputField(label: 'Area', hint: 'write area', controller: bloc.addressAreaController),
                SizedBox(height: 14.height),
                _InputField(label: 'Street Name', hint: 'write street', controller: bloc.addressStreetController),
                SizedBox(height: 14.height),
                _InputField(label: 'Building Number', hint: 'write building number', controller: bloc.addressBuildingController, keyboardType: TextInputType.number),
                SizedBox(height: 14.height),
                _InputField(label: 'Floor Number', hint: 'write floor number', controller: bloc.addressFloorController, keyboardType: TextInputType.number),
                SizedBox(height: 14.height),
                _InputField(label: 'Apartment Number', hint: 'write Apartment number', controller: bloc.addressApartmentController, keyboardType: TextInputType.number),
                SizedBox(height: 12.height),
                Row(
                  children: [
                    Checkbox(
                      value: state.saveAddressInfo,
                      onChanged: (v) => bloc.add(BookingSaveAddressInfoChanged(v ?? false)),
                      activeColor: AppColors.lightPrimaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    Text(
                      'Save Info',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.height),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(28.radius),
                      child: Container(
                        width: 52.width,
                        height: 52.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFDDE7F0), width: 1.5),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E293B)),
                      ),
                    ),
                    SizedBox(width: 12.width),
                    Expanded(
                      child: SizedBox(
                        height: 52.height,
                        child: ElevatedButton(
                          onPressed: () => _submit(context, state),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightPrimaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.radius),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.height),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;

  const _DropdownField({
    required this.label,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        SizedBox(height: 6.height),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text(hint, style: TextStyle(fontSize: context.responsiveFontScale(13), color: const Color(0xFFB0BEC5))),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFDDE7F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF368CE1)),
            ),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: context.responsiveFontScale(13)))))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        SizedBox(height: 6.height),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: context.responsiveFontScale(13), color: const Color(0xFFB0BEC5)),
            contentPadding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFDDE7F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF368CE1)),
            ),
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

    const spacing = 20.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // fake roads
    final roadPaint = Paint()
      ..color = const Color(0xFF93C5FD).withValues(alpha: .7)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.35, 0), Offset(size.width * 0.35, size.height), roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
