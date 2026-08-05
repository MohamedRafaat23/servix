import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final locationSearchController = TextEditingController();
  final addressAreaController = TextEditingController();
  final addressStreetController = TextEditingController();
  final addressBuildingController = TextEditingController();
  final addressFloorController = TextEditingController();
  final addressApartmentController = TextEditingController();
  BookingBloc()
      : super(BookingState(
          focusedMonth: DateTime.now(),
          selectedDate: DateTime.now(),
        )) {
    on<BookingAddressAdded>(_onAddressAdded);
    on<BookingAddressRemoved>(_onAddressRemoved);
    on<BookingAddressCountryChanged>((event, emit) => emit(state.copyWith(addressCountry: event.country)));
    on<BookingAddressCityChanged>((event, emit) => emit(state.copyWith(addressCity: event.city)));
    on<BookingSaveAddressInfoChanged>((event, emit) => emit(state.copyWith(saveAddressInfo: event.value)));
    on<BookingMonthChanged>(_onMonthChanged);
    on<BookingDateSelected>(_onDateSelected);
    on<BookingTimeSelected>(_onTimeSelected);
    on<BookingLocationSubmitted>(_onLocationSubmitted);
    on<BookingAppointmentSubmitted>(_onAppointmentSubmitted);
    on<BookingConfirmed>(_onConfirmed);
  }

  void _onAddressAdded(BookingAddressAdded event, Emitter<BookingState> emit) {
    emit(state.copyWith(addedAddresses: [...state.addedAddresses, event.address]));
  }

  void _onAddressRemoved(BookingAddressRemoved event, Emitter<BookingState> emit) {
    final updated = [...state.addedAddresses];
    updated.removeAt(event.index);
    emit(state.copyWith(addedAddresses: updated));
  }

  void _onMonthChanged(BookingMonthChanged event, Emitter<BookingState> emit) {
    emit(state.copyWith(focusedMonth: event.month));
  }

  void _onDateSelected(BookingDateSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onTimeSelected(BookingTimeSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedTime: event.time));
  }

  void _onLocationSubmitted(BookingLocationSubmitted event, Emitter<BookingState> emit) {
    emit(state.copyWith(isSubmitted: true));
  }

  Future<void> _onAppointmentSubmitted(BookingAppointmentSubmitted event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onConfirmed(BookingConfirmed event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false, isSubmitted: true));
  }

  @override
  Future<void> close() {
    locationSearchController.dispose();
    addressAreaController.dispose();
    addressStreetController.dispose();
    addressBuildingController.dispose();
    addressFloorController.dispose();
    addressApartmentController.dispose();
    return super.close();
  }
}
