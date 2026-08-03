import 'package:equatable/equatable.dart';
enum PasswordFieldType { old, newPass, confirm }

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  const FetchProfileEvent();
}

class UpdateProfileInformationEvent extends ProfileEvent {
  final String? name;
  final String? email;
  final String? avatarUrl;

  const UpdateProfileInformationEvent({
    this.name,
    this.email,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, email, avatarUrl];
}

class ChangeUserPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangeUserPasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class AddAddressProfileEvent extends ProfileEvent {
  final String address;

  const AddAddressProfileEvent(this.address);

  @override
  List<Object?> get props => [address];
}

class DeleteAddressProfileEvent extends ProfileEvent {
  final int index;

  const DeleteAddressProfileEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleNotificationsProfileEvent extends ProfileEvent {
  final bool enabled;

  const ToggleNotificationsProfileEvent(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ToggleNightModeProfileEvent extends ProfileEvent {
  final bool enabled;

  const ToggleNightModeProfileEvent(this.enabled);

  @override
  List<Object?> get props => [enabled];
}
class LanguageProfileEvent extends ProfileEvent {
  final String language;

  const LanguageProfileEvent(this.language);

  @override
  List<Object?> get props => [language];
}

class ChangePasswordObscureToggled extends ProfileEvent {
  final PasswordFieldType field;
  const ChangePasswordObscureToggled(this.field);

  @override
  List<Object?> get props => [field];
}