import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders({OrderStatusType? filterStatus});
  Future<Either<Failure, OrderEntity>> getOrderById(String id);
  Future<Either<Failure, void>> cancelOrder(String id);
  Future<Either<Failure, OrderEntity>> reorder(String id);
}
