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

class BookingAddressCountryChanged extends BookingEvent {
  final String? country;
  const BookingAddressCountryChanged(this.country);
  @override
  List<Object?> get props => [country];
}

class BookingAddressCityChanged extends BookingEvent {
  final String? city;
  const BookingAddressCityChanged(this.city);
  @override
  List<Object?> get props => [city];
}

class BookingSaveAddressInfoChanged extends BookingEvent {
  final bool value;
  const BookingSaveAddressInfoChanged(this.value);
  @override
  List<Object?> get props => [value];
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
