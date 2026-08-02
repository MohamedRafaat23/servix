import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/features/order/domain/usecases/get_order_details_usecase.dart';
import 'package:servix/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:servix/features/order/domain/usecases/reorder_usecase.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final ReorderUseCase reorderUseCase;

  OrderBloc({
    required this.getOrdersUseCase,
    required this.getOrderDetailsUseCase,
    required this.reorderUseCase,
  }) : super(const OrderState()) {
    on<FetchOrdersEvent>(_onFetchOrders);
    on<FetchOrderDetailsEvent>(_onFetchOrderDetails);
    on<ReorderEvent>(_onReorder);
  }

  Future<void> _onFetchOrders(
    FetchOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(
      status: OrderStatus.loading,
      selectedFilter: event.filterStatus,
      clearFilter: event.filterStatus == null,
    ));
    final result = await getOrdersUseCase(event.filterStatus);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrderStatus.failure,
        errorMessage: failure.message,
      )),
      (orders) => emit(state.copyWith(
        status: OrderStatus.success,
        orders: orders,
      )),
    );
  }

  Future<void> _onFetchOrderDetails(
    FetchOrderDetailsEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final result = await getOrderDetailsUseCase(event.orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrderStatus.failure,
        errorMessage: failure.message,
      )),
      (order) => emit(state.copyWith(
        status: OrderStatus.success,
        selectedOrder: order,
      )),
    );
  }

  Future<void> _onReorder(
    ReorderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    final result = await reorderUseCase(event.orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: failure.message,
      )),
      (newOrder) {
        final updatedList = [newOrder, ...state.orders];
        emit(state.copyWith(
          isSubmitting: false,
          orders: updatedList,
          selectedOrder: newOrder,
          actionSuccessMessage: 'Reorder placed successfully!',
        ));
      },
    );
  }
}
