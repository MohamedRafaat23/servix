import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/booking_args.dart';
import 'booking_scaffold.dart';
import 'confirm_booking_screen.dart';

class ChooseAppointmentScreen extends StatefulWidget {
  final BookingArgs args;

  const ChooseAppointmentScreen({super.key, required this.args});

  @override
  State<ChooseAppointmentScreen> createState() => _ChooseAppointmentScreenState();
}

class _ChooseAppointmentScreenState extends State<ChooseAppointmentScreen> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  String? _selectedTime;

  static const List<String> _timeSlots = [
    '9:00 AM', '10:00 AM', '11:00 AM',
    '1:00 PM', '2:00 PM', '3:00 PM',
    '4:00 PM', '5:00 PM', '6:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime.now();
    _selectedDate = DateTime.now();
    _selectedTime = '10:00 AM';
  }

  void _onNext() {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time slot')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmBookingScreen(
          args: widget.args.copyWith(
            selectedDate: _selectedDate,
            selectedTime: _selectedTime,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BookingScaffold(
      currentStep: 2,
      buttonLabel: 'Next',
      onNext: _onNext,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding, vertical: 8.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: 'Select Date'),
            SizedBox(height: 12.height),
            _DateSelector(
              focusedMonth: _focusedMonth,
              selectedDate: _selectedDate,
              onPreviousMonth: () => setState(() {
                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
              }),
              onNextMonth: () => setState(() {
                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
              }),
              onDateSelected: (d) => setState(() => _selectedDate = d),
            ),
            SizedBox(height: 24.height),
            _SectionTitle(title: 'Select Time'),
            SizedBox(height: 12.height),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _timeSlots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, i) {
                final slot = _timeSlots[i];
                final isSelected = slot == _selectedTime;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = slot),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.lightPrimaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? AppColors.lightPrimaryColor : const Color(0xFFDDE7F0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF334155),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.height),
            // Summary chip
            if (_selectedTime != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F7FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCDE3F5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: Color(0xFF368CE1), size: 18),
                    SizedBox(width: 8.width),
                    Expanded(
                      child: Text(
                        '${_selectedDate.day} ${_weekdayAbbr(_selectedDate.weekday)}, ${_selectedDate.year} - $_selectedTime',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: const Color(0xFF334155),
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

  String _weekdayAbbr(int w) {
    const abbrs = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbrs[w - 1];
  }
}

// ── Section title ─────────────────────────────────────────────────────────────

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
        color: const Color(0xFF1E293B),
      ),
    );
  }
}

// ── Date selector row ─────────────────────────────────────────────────────────

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
                color: const Color(0xFF1E293B),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Color(0xFF94A3B8)),
                  onPressed: onPreviousMonth,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: 8.width),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
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
                    color: isSelected ? AppColors.lightPrimaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.lightPrimaryColor : const Color(0xFFDDE7F0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekAbbr[d.weekday - 1],
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: isSelected ? Colors.white70 : const Color(0xFF94A3B8),
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Text(
                        '${d.day}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : const Color(0xFF1E293B),
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
