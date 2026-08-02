import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/booking_args.dart';
import 'booking_scaffold.dart';
import 'booking_success_screen.dart';

class ConfirmBookingScreen extends StatefulWidget {
  final BookingArgs args;

  const ConfirmBookingScreen({super.key, required this.args});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  bool _isLoading = false;

  void _onConfirm() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const BookingSuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args;
    final professional = args.professional;
    final address = args.selectedAddresses.isNotEmpty ? args.selectedAddresses.first : 'N/A';
    final totalWithFee = professional.pricePerHour + args.serviceFee;

    return BookingScaffold(
      currentStep: 3,
      buttonLabel: 'Confirm Booking',
      onNext: _onConfirm,
      isLoading: _isLoading,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
          vertical: 8.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Professional card
            Container(
              padding: EdgeInsets.all(14.width),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDDE7F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26.width,
                    backgroundImage: AssetImage(professional.imageAsset),
                  ),
                  SizedBox(width: 12.width),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          professional.name,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(15),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        SizedBox(height: 2.height),
                        Text(
                          '${professional.profession} · ${professional.distanceMiles} mi',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(height: 4.height),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                            SizedBox(width: 3.width),
                            Text(
                              '${professional.rating} · ${professional.jobsCount} Jobs',
                              style: TextStyle(fontSize: context.responsiveFontScale(12)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6.width),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFDDE7F0)),
                    ),
                    child: const Icon(Icons.check, color: Color(0xFF22C55E), size: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.height),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 14.height),
            _SummaryRow(label: 'Service', value: professional.profession),
            _SummaryRow(label: 'Address', value: address),
            _SummaryRow(label: 'Date', value: args.formattedDate),
            _SummaryRow(
              label: 'Base Rate',
              value: '\$${professional.pricePerHour.toStringAsFixed(2)}',
            ),
            _SummaryRow(
              label: 'Service Fee',
              value: '\$${args.serviceFee.toStringAsFixed(2)}',
            ),
            const Divider(color: Color(0xFFEEF2F7), thickness: 1.5),
            SizedBox(height: 4.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                Text(
                  '\$${totalWithFee.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: AppColors.greyColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: const Color(0xFF1E293B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
