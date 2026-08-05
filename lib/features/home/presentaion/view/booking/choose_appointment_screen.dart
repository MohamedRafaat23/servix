import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/booking_args.dart';
import 'package:servix/features/home/presentaion/bloc/booking_bloc.dart';
import 'package:servix/features/home/presentaion/bloc/booking_event.dart';
import 'package:servix/features/home/presentaion/bloc/booking_state.dart';
import 'booking_scaffold.dart';
import 'confirm_booking_screen.dart';

// top-level helper - متاحة لأي كلاس في الملف
String weekdayAbbr(int w) {
  const abbrs = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return abbrs[w - 1];
}

class ChooseAppointmentScreen extends StatelessWidget {
  final BookingArgs args;

  static const List<String> _timeSlots = [
    '9:00 AM', '10:00 AM', '11:00 AM',
    '1:00 PM', '2:00 PM', '3:00 PM',
    '4:00 PM', '5:00 PM', '6:00 PM',
  ];

  const ChooseAppointmentScreen({super.key, required this.args});

  void _onNext(BuildContext context, BookingState state) {
    final selectedTime = state.selectedTime;
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time slot')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BookingBloc>(),
          child: ConfirmBookingScreen(
            args: args.copyWith(
              selectedDate: state.selectedDate,
              selectedTime: selectedTime,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return _ChooseAppointmentScreenContent(
          args: args,
          state: state,
          onNext: () => _onNext(context, state),
          onMonthChanged: (month) => context.read<BookingBloc>().add(BookingMonthChanged(month)),
          onDateSelected: (date) => context.read<BookingBloc>().add(BookingDateSelected(date)),
          onTimeSelected: (time) => context.read<BookingBloc>().add(BookingTimeSelected(time)),
        );
      },
    );
  }
}

class _ChooseAppointmentScreenContent extends StatelessWidget {
  final BookingArgs args;
  final BookingState state;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onTimeSelected;

  const _ChooseAppointmentScreenContent({
    required this.args,
    required this.state,
    required this.onNext,
    required this.onMonthChanged,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BookingScaffold(
      currentStep: 2,
      buttonLabel: 'Next',
      onNext: onNext,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding, vertical: 8.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: 'Select Date'),
            SizedBox(height: 12.height),
            _DateSelector(
              focusedMonth: state.focusedMonth,
              selectedDate: state.selectedDate,
              onPreviousMonth: () => onMonthChanged(DateTime(state.focusedMonth.year, state.focusedMonth.month - 1)),
              onNextMonth: () => onMonthChanged(DateTime(state.focusedMonth.year, state.focusedMonth.month + 1)),
              onDateSelected: onDateSelected,
            ),
            SizedBox(height: 24.height),
            _SectionTitle(title: 'Select Time'),
            SizedBox(height: 12.height),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ChooseAppointmentScreen._timeSlots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, i) {
                final slot = ChooseAppointmentScreen._timeSlots[i];
                final isSelected = slot == state.selectedTime;
                return GestureDetector(
                  onTap: () => onTimeSelected(slot),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? colorScheme.primary : colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          fontWeight: FontWeight.w600,
                          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.height),
            if (state.selectedTime != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, color: colorScheme.primary, size: 18),
                    SizedBox(width: 8.width),
                    Expanded(
                      child: Text(
                        '${state.selectedDate.day} ${weekdayAbbr(state.selectedDate.weekday)}, ${state.selectedDate.year} - ${state.selectedTime}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 18),
                  ],
                ),
              ),
            SizedBox(height: 16.height),
          ],
        ),
      ),
    );
  }
}

//  Section title

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: context.responsiveFontScale(15),
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

//  Date selector row

class _DateSelector extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final void Function(DateTime) onDateSelected;

  const _DateSelector({
    required this.focusedMonth,
    required this.selectedDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // build 7 days starting from today
    final today = DateTime.now();
    final startDay = DateTime(focusedMonth.year, focusedMonth.month, today.day > 25 ? 1 : today.day);
    final days = List.generate(7, (i) => startDay.add(Duration(days: i)));

    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return Column(
      children: [
        // Month header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${monthNames[focusedMonth.month - 1]} ${focusedMonth.year}',
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, color: colorScheme.onSurface.withValues(alpha: .6)),
                  onPressed: onPreviousMonth,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: 8.width),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: colorScheme.onSurface.withValues(alpha: .6)),
                  onPressed: onNextMonth,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.height),
        // Days row
        SizedBox(
          height: 72.height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.width),
            itemBuilder: (_, i) {
              final d = days[i];
              final isSelected = d.day == selectedDate.day &&
                  d.month == selectedDate.month &&
                  d.year == selectedDate.year;
              const weekAbbr = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
              return GestureDetector(
                onTap: () => onDateSelected(d),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 50.width,
                  decoration: BoxDecoration(
                    color: isSelected ? colorScheme.primary : colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekAbbr[d.weekday - 1],
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: isSelected ? colorScheme.onPrimary.withValues(alpha: .75) : colorScheme.onSurface.withValues(alpha: .6),
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Text(
                        '${d.day}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.bold,
                          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
