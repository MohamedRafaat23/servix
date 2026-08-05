import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'map_grid_painter.dart';
import 'sheet_dropdown.dart';
import 'sheet_input.dart';

class AddAddressSheet extends StatelessWidget {
  final void Function(String address) onSave;
   AddAddressSheet({super.key, required this.onSave});

  final List<String> _countries = ['Saudi Arabia', 'Egypt', 'UAE', 'Kuwait', 'Jordan'];
  final List<String> _cities = ['Riyadh', 'Jeddah', 'Mecca', 'Cairo', 'Dubai'];

  void _save(BuildContext context, ProfileState state) {
    final area = context.read<ProfileBloc>().addressAreaCtrl.text.trim();
    final country = state.selectedAddressCountry ?? '';
    if (area.isEmpty && country.isEmpty) return;
    final address = '${area.isNotEmpty ? area : state.selectedAddressCity ?? ''} - ${country.isNotEmpty ? country : "Unknown"}';
    onSave(address);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    final state = context.watch<ProfileBloc>().state;
    final colorScheme = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, sc) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              AppStrings.addNewAddress,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.height),
            Container(
              height: 140.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: colorScheme.surfaceContainerHighest,
                border: Border.all(color: colorScheme.outlineVariant),
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
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 6),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.my_location, color: colorScheme.primary, size: 14.width),
                            SizedBox(width: 5.width),
                            Text(
                              AppStrings.setLocationInMap,
                              style: TextStyle(
                                color: colorScheme.primary,
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
              label: AppStrings.chooseCountry,
              hint: AppStrings.chooseCountryHint,
              items: _countries,
              value: state.selectedAddressCountry,
              onChanged: (v) => bloc.add(AddressCountryChanged(v)),
            ),
            SizedBox(height: 12.height),
            SheetDropdown(
              label: AppStrings.chooseCity,
              hint: AppStrings.chooseCityHint,
              items: _cities,
              value: state.selectedAddressCity,
              onChanged: (v) => bloc.add(AddressCityChanged(v)),
            ),
            SizedBox(height: 12.height),
            SheetInput(label: AppStrings.area, hint: AppStrings.writeArea, controller: bloc.addressAreaCtrl),
            SizedBox(height: 12.height),
            SheetInput(label: AppStrings.streetName, hint: AppStrings.writeStreetName, controller: bloc.addressStreetCtrl),
            SizedBox(height: 12.height),
            SheetInput(
              label: AppStrings.buildingNumber,
              hint: AppStrings.writeBuildingNumber,
              controller: bloc.addressBuildingCtrl,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.height),
            SheetInput(
              label: AppStrings.floorNumber,
              hint: AppStrings.writeFloorNumber,
              controller: bloc.addressFloorCtrl,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.height),
            SheetInput(
              label: AppStrings.apartmentNumber,
              hint: AppStrings.writeApartmentNumber,
              controller: bloc.addressApartmentCtrl,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.height),
            SizedBox(
              width: double.infinity,
              height: 52.height,
              child: ElevatedButton(
                onPressed: () => _save(context, state),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.radius)),
                ),
                child: Text(
                  AppStrings.save,
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
