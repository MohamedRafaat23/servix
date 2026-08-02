import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';
import 'package:servix/features/order/domain/repositories/order_repository.dart';

class GetOrderDetailsUseCase implements UseCase<OrderEntity, String> {
  final OrderRepository repository;

  GetOrderDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, OrderEntity>> call(String id) async {
    return await repository.getOrderById(id);
  }
}
