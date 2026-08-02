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

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
    required this.addSavedAddressUseCase,
    required this.deleteSavedAddressUseCase,
  }) : super(const ProfileState()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileInformationEvent>(_onUpdateProfileInformation);
    on<ChangeUserPasswordEvent>(_onChangeUserPassword);
    on<AddAddressProfileEvent>(_onAddAddress);
    on<DeleteAddressProfileEvent>(_onDeleteAddress);
    on<ToggleNotificationsProfileEvent>(_onToggleNotifications);
    on<ToggleNightModeProfileEvent>(_onToggleNightMode);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await getProfileUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: failure.message,
      )),
      (profile) => emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      )),
    );
  }

  Future<void> _onUpdateProfileInformation(
    UpdateProfileInformationEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    final result = await updateProfileUseCase(
      UpdateProfileParams(
        name: event.name,
        email: event.email,
        avatarUrl: event.avatarUrl,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: failure.message,
      )),
      (updatedProfile) => emit(state.copyWith(
        isSubmitting: false,
        profile: updatedProfile,
        successMessage: 'Profile updated successfully',
      )),
    );
  }

  Future<void> _onChangeUserPassword(
    ChangeUserPasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    final result = await changePasswordUseCase(
      ChangePasswordParams(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isSubmitting: false,
        successMessage: 'Password changed successfully',
      )),
    );
  }

  Future<void> _onAddAddress(
    AddAddressProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
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

  Future<void> _onDeleteAddress(
    DeleteAddressProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
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

  void _onToggleNotifications(
    ToggleNotificationsProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (state.profile != null) {
      final updated = state.profile!.copyWith(notificationsEnabled: event.enabled);
      emit(state.copyWith(profile: updated));
    }
  }

  void _onToggleNightMode(
    ToggleNightModeProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (state.profile != null) {
      final updated = state.profile!.copyWith(nightModeEnabled: event.enabled);
      emit(state.copyWith(profile: updated));
    }
  }
}
