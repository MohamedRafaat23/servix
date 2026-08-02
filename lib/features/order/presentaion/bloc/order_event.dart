import 'package:equatable/equatable.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrdersEvent extends OrderEvent {
  final OrderStatusType? filterStatus; // null = All

  const FetchOrdersEvent({this.filterStatus});

  @override
  List<Object?> get props => [filterStatus];
}

class FetchOrderDetailsEvent extends OrderEvent {
  final String orderId;

  const FetchOrderDetailsEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class ReorderEvent extends OrderEvent {
  final String orderId;

  const ReorderEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
