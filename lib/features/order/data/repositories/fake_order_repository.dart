import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';
import 'package:servix/features/order/domain/repositories/order_repository.dart';

class FakeOrderRepository implements OrderRepository {
  static const _delay = Duration(milliseconds: 300);

  final List<OrderEntity> _orders = [
    const OrderEntity(
      id: 'ord_1',
      providerName: 'David Chen',
      profession: 'Master Plumber',
      providerImage: AppImages.frame1,
      rating: 4.5,
      jobsCount: 890,
      status: OrderStatusType.pending,
      date: 'Tue, Mar 12',
      time: '10:00 AM',
      address: '128 Berry St, Brooklyn',
      serviceName: 'Plumbing',
      baseRate: 65.00,
      serviceFee: 4.99,
      timelineSteps: [
        OrderTimelineStepEntity(stepNumber: 1, title: 'Booking Confirmed', timeOrStatus: '09:12 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 2, title: 'On The Way', timeOrStatus: '10:02 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 3, title: 'Arrived', timeOrStatus: '10:24 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 4, title: 'start Worked', timeOrStatus: 'Pending', isCompleted: false, isCurrent: true),
        OrderTimelineStepEntity(stepNumber: 5, title: 'Payment', timeOrStatus: 'Pending', isCompleted: false),
      ],
    ),
    const OrderEntity(
      id: 'ord_2',
      providerName: 'Maicil Rashil',
      profession: 'Certified HVAC',
      providerImage: AppImages.frame2,
      rating: 4.9,
      jobsCount: 670,
      status: OrderStatusType.completed,
      date: 'Tue, Mar 24',
      time: '10:00 AM',
      address: '128 Berry St, Brooklyn',
      serviceName: 'Plumbing',
      baseRate: 77.01,
      serviceFee: 4.99,
      timelineSteps: [
        OrderTimelineStepEntity(stepNumber: 1, title: 'Booking Confirmed', timeOrStatus: '09:12 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 2, title: 'On The Way', timeOrStatus: '10:02 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 3, title: 'Arrived', timeOrStatus: '10:24 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 4, title: 'start Worked', timeOrStatus: 'Completed', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 5, title: 'Payment', timeOrStatus: 'Completed', isCompleted: true),
      ],
    ),
    const OrderEntity(
      id: 'ord_3',
      providerName: 'David Chen',
      profession: 'Senior HVAC Technician',
      providerImage: AppImages.frame1,
      rating: 4.5,
      jobsCount: 890,
      status: OrderStatusType.cancelled,
      date: 'Tue, Mar 12',
      time: '10:00 AM',
      address: '128 Berry St, Brooklyn',
      serviceName: 'Plumbing',
      baseRate: 115.01,
      serviceFee: 4.99,
      cancelReason: "The Worker Couldn't Reach The Specified Address",
      timelineSteps: [
        OrderTimelineStepEntity(stepNumber: 1, title: 'Booking Confirmed', timeOrStatus: '09:12 AM', isCompleted: false),
        OrderTimelineStepEntity(stepNumber: 2, title: 'On The Way', timeOrStatus: '10:02 AM', isCompleted: false),
        OrderTimelineStepEntity(stepNumber: 3, title: 'Arrived', timeOrStatus: '10:24 AM', isCompleted: false),
        OrderTimelineStepEntity(stepNumber: 4, title: 'start Worked', timeOrStatus: 'Pending', isCompleted: false),
        OrderTimelineStepEntity(stepNumber: 5, title: 'Payment', timeOrStatus: 'Pending', isCompleted: false),
      ],
    ),
    const OrderEntity(
      id: 'ord_4',
      providerName: "James O'Connor",
      profession: 'Professional Electrician',
      providerImage: AppImages.frame2,
      rating: 4.8,
      jobsCount: 1120,
      status: OrderStatusType.completed,
      date: 'Tue, Mar 24',
      time: '10:00 AM',
      address: '128 Berry St, Brooklyn',
      serviceName: 'Electrical Work',
      baseRate: 59.01,
      serviceFee: 4.99,
      timelineSteps: [
        OrderTimelineStepEntity(stepNumber: 1, title: 'Booking Confirmed', timeOrStatus: '09:12 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 2, title: 'On The Way', timeOrStatus: '10:02 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 3, title: 'Arrived', timeOrStatus: '10:24 AM', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 4, title: 'start Worked', timeOrStatus: 'Completed', isCompleted: true),
        OrderTimelineStepEntity(stepNumber: 5, title: 'Payment', timeOrStatus: 'Completed', isCompleted: true),
      ],
    ),
  ];

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({OrderStatusType? filterStatus}) async {
    await Future.delayed(_delay);
    if (filterStatus == null) {
      return Right(List.from(_orders));
    }
    return Right(_orders.where((o) => o.status == filterStatus).toList());
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(String id) async {
    await Future.delayed(_delay);
    try {
      final order = _orders.firstWhere((o) => o.id == id);
      return Right(order);
    } catch (_) {
      return Left(ServerFailure(AppStrings.ordernoyfound));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder(String id) async {
    await Future.delayed(_delay);
    final index = _orders.indexWhere((o) => o.id == id);
    if (index != -1) {
      // update status to cancelled
      _orders[index] = OrderEntity(
        id: _orders[index].id,
        providerName: _orders[index].providerName,
        profession: _orders[index].profession,
        providerImage: _orders[index].providerImage,
        rating: _orders[index].rating,
        jobsCount: _orders[index].jobsCount,
        status: OrderStatusType.cancelled,
        date: _orders[index].date,
        time: _orders[index].time,
        address: _orders[index].address,
        serviceName: _orders[index].serviceName,
        baseRate: _orders[index].baseRate,
        serviceFee: _orders[index].serviceFee,
        cancelReason: "Cancelled by User",
        timelineSteps: _orders[index].timelineSteps,
      );
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, OrderEntity>> reorder(String id) async {
    await Future.delayed(_delay);
    try {
      final old = _orders.firstWhere((o) => o.id == id);
      final newOrder = OrderEntity(
        id: 'ord_${DateTime.now().millisecondsSinceEpoch}',
        providerName: old.providerName,
        profession: old.profession,
        providerImage: old.providerImage,
        rating: old.rating,
        jobsCount: old.jobsCount,
        status: OrderStatusType.pending,
        date: AppStrings.date,
        time: '10:00 AM',
        address: old.address,
        serviceName: old.serviceName,
        baseRate: old.baseRate,
        serviceFee: old.serviceFee,
        timelineSteps:  [
          OrderTimelineStepEntity(stepNumber: 1, title: AppStrings.bookingConfirmed, timeOrStatus: 'Just now', isCompleted: true),
          OrderTimelineStepEntity(stepNumber: 2, title: AppStrings.onTheWay, timeOrStatus: 'Pending', isCompleted: false, isCurrent: true),
          OrderTimelineStepEntity(stepNumber: 3, title: AppStrings.arrived, timeOrStatus: 'Pending', isCompleted: false),
          OrderTimelineStepEntity(stepNumber: 4, title: AppStrings.startWorked, timeOrStatus: 'Pending', isCompleted: false),
          OrderTimelineStepEntity(stepNumber: 5, title: AppStrings.payment, timeOrStatus: 'Pending', isCompleted: false),
        ],
      );
      _orders.insert(0, newOrder);
      return Right(newOrder);
    } catch (_) {
      return Left(ServerFailure('Failed to reorder'));
    }
  }
}
