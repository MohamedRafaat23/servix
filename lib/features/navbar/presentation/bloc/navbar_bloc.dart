import 'package:flutter_bloc/flutter_bloc.dart';
import 'navbar_event.dart';
import 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState()) {
    on<NavbarPageChanged>(_onPageChanged);
  }

  void _onPageChanged(NavbarPageChanged event, Emitter<NavbarState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }
}