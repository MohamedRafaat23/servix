// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:servix/features/profile/domain/entites/profile_entity.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileEntity? profile;
  final String? errorMessage;
  final String? successMessage;
  final bool isSubmitting;
  final bool obscureOldPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final String selectedLanguage;
  final String? selectedAddressCountry;
  final String? selectedAddressCity;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.successMessage,
    this.isSubmitting = false,
    this.obscureOldPassword = false,
    this.obscureNewPassword = false,
    this.obscureConfirmPassword = false,
    this.selectedLanguage = 'en',
    this.selectedAddressCountry,
    this.selectedAddressCity,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileEntity? profile,
    String? errorMessage,
    String? successMessage,
    bool? isSubmitting,
    bool? obscureOldPassword,
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
    String? selectedLanguage,
    String? selectedAddressCountry,
    String? selectedAddressCity,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      obscureOldPassword: obscureOldPassword ?? this.obscureOldPassword,
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedAddressCountry: selectedAddressCountry,
      selectedAddressCity: selectedAddressCity,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profile,
        errorMessage,
        successMessage,
        isSubmitting,
        obscureOldPassword,
        obscureNewPassword,
        obscureConfirmPassword,
        selectedLanguage,
        selectedAddressCountry,
        selectedAddressCity,
      ];
}
