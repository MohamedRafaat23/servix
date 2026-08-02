import 'package:equatable/equatable.dart';
import 'package:servix/features/profile/domain/entites/profile_entity.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileEntity? profile;
  final String? errorMessage;
  final String? successMessage;
  final bool isSubmitting;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.successMessage,
    this.isSubmitting = false,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileEntity? profile,
    String? errorMessage,
    String? successMessage,
    bool? isSubmitting,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
        status,
        profile,
        errorMessage,
        successMessage,
        isSubmitting,
      ];
}
