import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.name,
    super.email,
    super.phone,
    required super.accessToken,
    required super.refreshToken,
    super.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // NOTE: adjust these keys to match Sevix's actual API response
    // once the backend contract is confirmed.
    final user = json['user'] ?? json;

    return UserModel(
      id: user['id']?.toString() ?? '',
      name: user['name'],
      email: user['email'],
      phone: user['phone'],
      accessToken: json['access'] ?? json['access_token'] ?? '',
      refreshToken: json['refresh'] ?? json['refresh_token'] ?? '',
      isVerified: json['is_verified'] ?? true,
    );
  }
}