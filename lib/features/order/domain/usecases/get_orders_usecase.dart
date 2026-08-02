import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';
import 'package:servix/features/order/domain/repositories/order_repository.dart';

class GetOrdersUseCase implements UseCase<List<OrderEntity>, OrderStatusType?> {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call(OrderStatusType? filterStatus) async {
    return await repository.getOrders(filterStatus: filterStatus);
  }
}
