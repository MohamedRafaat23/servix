import 'package:equatable/equatable.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderEntity> orders;
  final OrderStatusType? selectedFilter;
  final OrderEntity? selectedOrder;
  final String? errorMessage;
  final String? actionSuccessMessage;
  final bool isSubmitting;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders = const [],
    this.selectedFilter,
    this.selectedOrder,
    this.errorMessage,
    this.actionSuccessMessage,
    this.isSubmitting = false,
  });

  OrderState copyWith({
    OrderStatus? status,
    List<OrderEntity>? orders,
    OrderStatusType? selectedFilter,
    bool clearFilter = false,
    OrderEntity? selectedOrder,
    String? errorMessage,
    String? actionSuccessMessage,
    bool? isSubmitting,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      selectedFilter: clearFilter ? null : (selectedFilter ?? this.selectedFilter),
      selectedOrder: selectedOrder ?? this.selectedOrder,
      errorMessage: errorMessage,
      actionSuccessMessage: actionSuccessMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
        status,
        orders,
        selectedFilter,
        selectedOrder,
        errorMessage,
        actionSuccessMessage,
        isSubmitting,
      ];
}
