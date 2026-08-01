import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String accessToken;
  final String refreshToken;
  final bool isVerified;

  const UserEntity({
    required this.id,
    this.name,
    this.email,
    this.phone,
    required this.accessToken,
    required this.refreshToken,
    this.isVerified = true,
  });

  @override
  List<Object?> get props => [id, name, email, phone, accessToken, refreshToken, isVerified];
}