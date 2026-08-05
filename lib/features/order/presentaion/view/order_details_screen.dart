import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';
import 'package:servix/features/order/presentaion/bloc/order_bloc.dart';
import 'package:servix/features/order/presentaion/bloc/order_event.dart';
import 'package:servix/features/order/presentaion/bloc/order_state.dart';
import 'widgets/order_cancelled_banner.dart';
import 'widgets/order_details_header_card.dart';
import 'widgets/order_summary_section.dart';
import 'widgets/order_timeline_stepper.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCancelled = order.status == OrderStatusType.cancelled;

    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.actionSuccessMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.actionSuccessMessage!),
              backgroundColor: AppColors.lightPrimaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            AppStrings.orderDetails,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        body: AppBackground(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                    vertical: 12.height,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderDetailsHeaderCard(order: order),
                      SizedBox(height: 20.height),
                      OrderSummarySection(order: order),
                      SizedBox(height: 24.height),
                      OrderTimelineStepper(order: order),
                      if (isCancelled && order.cancelReason != null) ...[
                        SizedBox(height: 20.height),
                        OrderCancelledBanner(reason: order.cancelReason!),
                      ],
                      SizedBox(height: 24.height),
                    ],
                  ),
                ),
              ),
              // Bottom Action Button (Contact or Reorder)
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                    vertical: 14.height,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.height,
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (isCancelled) {
                          return ElevatedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () {
                                    context.read<OrderBloc>().add(ReorderEvent(order.id));
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.radius),
                              ),
                            ),
                            child: state.isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  )
                                : Text(
                                   AppStrings.reorder,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(16),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        }

                        return ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${AppStrings.calling} ${order.providerName}...'),
                                backgroundColor: colorScheme.primary,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          },
                          icon: const Icon(Icons.phone_outlined, color: Colors.white),
                          label: Text(
                            AppStrings.contact,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.radius),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
