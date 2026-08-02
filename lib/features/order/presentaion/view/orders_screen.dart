import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/order/presentaion/bloc/order_bloc.dart';
import 'package:servix/features/order/presentaion/bloc/order_event.dart';
import 'package:servix/features/order/presentaion/bloc/order_state.dart';
import 'order_details_screen.dart';
import 'widgets/order_card.dart';
import 'widgets/order_filter_chips.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrderBloc>()..add(const FetchOrdersEvent()),
      child: const _OrdersScreenBody(),
    );
  }
}

class _OrdersScreenBody extends StatelessWidget {
  const _OrdersScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.height),
              Text(
                'Orders',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(20),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: 16.height),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return OrderFilterChips(
                    selectedFilter: state.selectedFilter,
                    onFilterChanged: (filter) {
                      context.read<OrderBloc>().add(FetchOrdersEvent(filterStatus: filter));
                    },
                  );
                },
              ),
              SizedBox(height: 16.height),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state.status == OrderStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == OrderStatus.failure) {
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Failed to load orders',
                          style: const TextStyle(color: Color(0xFFEF4444)),
                        ),
                      );
                    }

                    if (state.orders.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 64.width,
                              color: const Color(0xFFDDE7F0),
                            ),
                            SizedBox(height: 12.height),
                            Text(
                              'No orders found',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(15),
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.only(
                        left: context.responsiveHorizontalPadding,
                        right: context.responsiveHorizontalPadding,
                        bottom: 110.height,
                      ),
                      itemCount: state.orders.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.height),
                      itemBuilder: (_, index) {
                        final order = state.orders[index];
                        return OrderCard(
                          order: order,
                          onTap: () {
                            final bloc = context.read<OrderBloc>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: bloc,
                                  child: OrderDetailsScreen(order: order),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}