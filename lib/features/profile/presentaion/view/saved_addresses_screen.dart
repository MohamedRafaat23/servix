import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/address_card.dart';
import 'widgets/add_address_sheet.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  void _removeAddress(BuildContext context, int index) {
    context.read<ProfileBloc>().add(DeleteAddressProfileEvent(index));
  }

  void _showAddAddressSheet(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: AddAddressSheet(
          onSave: (address) {
            bloc.add(AddAddressProfileEvent(address));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.savedAddresses,
          style: TextStyle(
            fontSize: context.responsiveFontScale(18),
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
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
                                  color: colorScheme.onSurface.withValues(alpha: .65),
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
                          itemBuilder: (_, i) => AddressCard(
                            address: addresses[i],
                            onDelete: () => _removeAddress(context, i),
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
                        onPressed: () => _showAddAddressSheet(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.radius),
                          ),
                        ),
                        child: Text(
                          '${AppStrings.addNewAddress} +',
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
