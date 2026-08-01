import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String city;
  final String country;
  final String streetAdress;

  const RegisterSubmitted({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.city,
    required this.country,
    required this.streetAdress,
  });

  @override
  List<Object?> get props => [name, phone, email, password, city, country, streetAdress];
}
class RegisterObscurePasswordToggled extends RegisterEvent {
  const RegisterObscurePasswordToggled();
}
