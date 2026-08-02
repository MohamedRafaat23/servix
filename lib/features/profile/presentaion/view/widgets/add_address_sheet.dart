import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'map_grid_painter.dart';
import 'sheet_dropdown.dart';
import 'sheet_input.dart';

class AddAddressSheet extends StatefulWidget {
  final void Function(String address) onSave;
  const AddAddressSheet({super.key, required this.onSave});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
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
                      painter: MapGridPainter(),
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
                            Text(
                              'Set Location In Map',
                              style: TextStyle(
                                color: AppColors.lightPrimaryColor,
                                fontSize: context.responsiveFontScale(12),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.height),
            SheetDropdown(
              label: 'Country',
              hint: 'choose country',
              items: _countries,
              value: _country,
              onChanged: (v) => setState(() => _country = v),
            ),
            SizedBox(height: 12.height),
            SheetDropdown(
              label: 'City',
              hint: 'choose city',
              items: _cities,
              value: _city,
              onChanged: (v) => setState(() => _city = v),
            ),
            SizedBox(height: 12.height),
            SheetInput(label: 'Area', hint: 'write area', controller: _areaCtrl),
            SizedBox(height: 12.height),
            SheetInput(label: 'Street Name', hint: 'write street', controller: _streetCtrl),
            SizedBox(height: 12.height),
            SheetInput(
              label: 'Building Number',
              hint: 'write building number',
              controller: _buildingCtrl,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.height),
            SheetInput(
              label: 'Floor Number',
              hint: 'write floor number',
              controller: _floorCtrl,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.height),
            SheetInput(
              label: 'Apartment Number',
              hint: 'write Apartment number',
              controller: _apartmentCtrl,
              keyboardType: TextInputType.number,
            ),
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
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: context.responsiveFontScale(16), fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 24.height),
          ],
        ),
      ),
    );
  }
}