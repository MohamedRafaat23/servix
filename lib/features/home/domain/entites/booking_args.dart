import 'package:servix/features/home/domain/entites/professional_entity.dart';

/// Holds all data gathered across the multi-step booking wizard.
class BookingArgs {
  final ProfessionalEntity professional;
  final List<String> selectedAddresses;
  final DateTime? selectedDate;
  final String? selectedTime;

  const BookingArgs({
    required this.professional,
    this.selectedAddresses = const [],
    this.selectedDate,
    this.selectedTime,
  });

  BookingArgs copyWith({
    ProfessionalEntity? professional,
    List<String>? selectedAddresses,
    DateTime? selectedDate,
    String? selectedTime,
  }) {
    return BookingArgs(
      professional: professional ?? this.professional,
      selectedAddresses: selectedAddresses ?? this.selectedAddresses,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  double get serviceFee => 4.99;

  double get total => (professional.pricePerHour) + serviceFee;

  String get formattedDate {
    if (selectedDate == null) return '';
    final d = selectedDate!;
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${d.day} ${weekdays[d.weekday - 1]}, ${d.year} - $selectedTime';
  }
}
