// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:servix/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:servix/features/profile/domain/usecases/manage_addresses_usecase.dart';
import 'package:servix/features/profile/domain/usecases/update_profile_usecase.dart';

import 'profile_event.dart';
import 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final AddSavedAddressUseCase addSavedAddressUseCase;
  final DeleteSavedAddressUseCase deleteSavedAddressUseCase;

  final profileFormKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  // خاصة بشاشة Change Password - نفس نمط LoginBloc/OtpBloc
  final changePasswordFormKey = GlobalKey<FormState>();
  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final addressAreaCtrl = TextEditingController();
  final addressStreetCtrl = TextEditingController();
  final addressBuildingCtrl = TextEditingController();
  final addressFloorCtrl = TextEditingController();
  final addressApartmentCtrl = TextEditingController();

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
    required this.addSavedAddressUseCase,
    required this.deleteSavedAddressUseCase,
  }) : super(const ProfileState()) {
    nameCtrl.text = 'Khaled Ali';
    emailCtrl.text = 'Alikhaled33@gmail.com';

    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileInformationEvent>(_onUpdateProfileInformation);
    on<ChangeUserPasswordEvent>(_onChangeUserPassword);
    on<AddAddressProfileEvent>(_onAddAddress);
    on<AddressCountryChanged>(_onAddressCountryChanged);
    on<AddressCityChanged>(_onAddressCityChanged);
    on<DeleteAddressProfileEvent>(_onDeleteAddress);
    on<ToggleNotificationsProfileEvent>(_onToggleNotifications);
    on<ToggleNightModeProfileEvent>(_onToggleNightMode);
    on<LanguageProfileEvent>(_onChangeLanguage);
    on<ChangePasswordObscureToggled>(_onObscureToggled);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await getProfileUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, errorMessage: failure.message)),
      (profile) {
        nameCtrl.text = profile.name.isEmpty ? 'Khaled Ali' : profile.name;
        emailCtrl.text = profile.email.isEmpty ? 'Alikhaled33@gmail.com' : profile.email;
        emit(state.copyWith(status: ProfileStatus.success, profile: profile));
      },
    );
  }

  Future<void> _onUpdateProfileInformation(
    UpdateProfileInformationEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    final result = await updateProfileUseCase(
      UpdateProfileParams(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        avatarUrl: event.avatarUrl,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, errorMessage: failure.message)),
      (updatedProfile) {
        nameCtrl.text = updatedProfile.name.isEmpty ? nameCtrl.text : updatedProfile.name;
        emailCtrl.text = updatedProfile.email.isEmpty ? emailCtrl.text : updatedProfile.email;
        emit(state.copyWith(
          isSubmitting: false,
          profile: updatedProfile,
          successMessage: 'Profile updated successfully',
        ));
      },
    );
  }

  Future<void> _onChangeUserPassword(
    ChangeUserPasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    final result = await changePasswordUseCase(
      ChangePasswordParams(oldPassword: event.oldPassword, newPassword: event.newPassword),
    );
    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isSubmitting: false, successMessage: 'Password changed successfully')),
    );
  }

  Future<void> _onAddAddress(AddAddressProfileEvent event, Emitter<ProfileState> emit) async {
    final result = await addSavedAddressUseCase(event.address);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (addresses) {
        if (state.profile != null) {
          final updated = state.profile!.copyWith(savedAddresses: addresses);
          emit(state.copyWith(profile: updated));
        }
      },
    );
  }

  Future<void> _onDeleteAddress(DeleteAddressProfileEvent event, Emitter<ProfileState> emit) async {
    final result = await deleteSavedAddressUseCase(event.index);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (addresses) {
        if (state.profile != null) {
          final updated = state.profile!.copyWith(savedAddresses: addresses);
          emit(state.copyWith(profile: updated));
        }
      },
    );
  }

  void _onAddressCountryChanged(
    AddressCountryChanged event,
    Emitter<ProfileState> emit,
  ) => emit(state.copyWith(selectedAddressCountry: event.country));

  void _onAddressCityChanged(
    AddressCityChanged event,
    Emitter<ProfileState> emit,
  ) => emit(state.copyWith(selectedAddressCity: event.city));

  void _onToggleNotifications(ToggleNotificationsProfileEvent event, Emitter<ProfileState> emit) {
    if (state.profile != null) {
      final updated = state.profile!.copyWith(notificationsEnabled: event.enabled);
      emit(state.copyWith(profile: updated));
    }
  }

  void _onToggleNightMode(ToggleNightModeProfileEvent event, Emitter<ProfileState> emit) {
    if (state.profile != null) {
      final updated = state.profile!.copyWith(nightModeEnabled: event.enabled);
      emit(state.copyWith(profile: updated));
    }
  }

 
  void _onChangeLanguage(LanguageProfileEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selectedLanguage: event.language));
    if (state.profile != null) {
      final updated = state.profile!.copyWith(language: event.language);
      emit(state.copyWith(profile: updated, selectedLanguage: event.language));
    }
  }

  void _onObscureToggled(ChangePasswordObscureToggled event, Emitter<ProfileState> emit) {
    switch (event.field) {
      case PasswordFieldType.old:
        emit(state.copyWith(obscureOldPassword: !state.obscureOldPassword));
        break;
      case PasswordFieldType.newPass:
        emit(state.copyWith(obscureNewPassword: !state.obscureNewPassword));
        break;
      case PasswordFieldType.confirm:
        emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
        break;
    }
  }

  @override
  Future<void> close() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    oldPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    addressAreaCtrl.dispose();
    addressStreetCtrl.dispose();
    addressBuildingCtrl.dispose();
    addressFloorCtrl.dispose();
    addressApartmentCtrl.dispose();
    return super.close();
  }
}
