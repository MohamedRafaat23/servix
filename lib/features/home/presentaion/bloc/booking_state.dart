import 'package:equatable/equatable.dart';

class BookingState extends Equatable {
  final List<String> addedAddresses;
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final String? selectedTime;
  final bool isLoading;
  final bool isSubmitted;

  const BookingState({
    this.addedAddresses = const ['Olaya District - Riyadh'],
    required this.focusedMonth,
    required this.selectedDate,
    this.selectedTime = '10:00 AM',
    this.isLoading = false,
    this.isSubmitted = false,
  });

  BookingState copyWith({
    List<String>? addedAddresses,
    DateTime? focusedMonth,
    DateTime? selectedDate,
    String? selectedTime,
    bool? isLoading,
    bool? isSubmitted,
  }) {
    return BookingState(
      addedAddresses: addedAddresses ?? this.addedAddresses,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [addedAddresses, focusedMonth, selectedDate, selectedTime, isLoading, isSubmitted];
}
