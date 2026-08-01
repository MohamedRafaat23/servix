import 'package:equatable/equatable.dart';

abstract class NavbarEvent extends Equatable {
  const NavbarEvent();
  @override
  List<Object?> get props => [];
}

class NavbarPageChanged extends NavbarEvent {
  final int index;
  const NavbarPageChanged(this.index);

  @override
  List<Object?> get props => [index];
}
