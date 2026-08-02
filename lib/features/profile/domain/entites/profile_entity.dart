import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final List<String> savedAddresses;
  final bool notificationsEnabled;
  final bool nightModeEnabled;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.savedAddresses = const [],
    this.notificationsEnabled = false,
    this.nightModeEnabled = true,
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    List<String>? savedAddresses,
    bool? notificationsEnabled,
    bool? nightModeEnabled,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      nightModeEnabled: nightModeEnabled ?? this.nightModeEnabled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        avatarUrl,
        savedAddresses,
        notificationsEnabled,
        nightModeEnabled,
      ];
}
