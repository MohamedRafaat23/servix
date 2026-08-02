import 'package:servix/features/profile/domain/entites/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.avatarUrl,
    super.savedAddresses = const [],
    super.notificationsEnabled = false,
    super.nightModeEnabled = true,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      savedAddresses: (json['saved_addresses'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      notificationsEnabled: json['notifications_enabled'] as bool? ?? false,
      nightModeEnabled: json['night_mode_enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'saved_addresses': savedAddresses,
      'notifications_enabled': notificationsEnabled,
      'night_mode_enabled': nightModeEnabled,
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      avatarUrl: entity.avatarUrl,
      savedAddresses: entity.savedAddresses,
      notificationsEnabled: entity.notificationsEnabled,
      nightModeEnabled: entity.nightModeEnabled,
    );
  }
}
