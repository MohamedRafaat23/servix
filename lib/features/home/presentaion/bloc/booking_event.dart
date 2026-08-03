import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingAddressAdded extends BookingEvent {
  final String address;

  const BookingAddressAdded(this.address);

  @override
  List<Object?> get props => [address];
}

class BookingAddressRemoved extends BookingEvent {
  final int index;

  const BookingAddressRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class BookingMonthChanged extends BookingEvent {
  final DateTime month;

  const BookingMonthChanged(this.month);

  @override
  List<Object?> get props => [month];
}

class BookingDateSelected extends BookingEvent {
  final DateTime date;

  const BookingDateSelected(this.date);

  @override
  List<Object?> get props => [date];
}

class BookingTimeSelected extends BookingEvent {
  final String time;

  const BookingTimeSelected(this.time);

  @override
  List<Object?> get props => [time];
}

class BookingLocationSubmitted extends BookingEvent {
  const BookingLocationSubmitted();
}

class BookingAppointmentSubmitted extends BookingEvent {
  const BookingAppointmentSubmitted();
}

class BookingConfirmed extends BookingEvent {
  const BookingConfirmed();
}
