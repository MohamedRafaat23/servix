import 'package:equatable/equatable.dart';

enum OrderStatusType { pending, completed, cancelled }

class OrderTimelineStepEntity extends Equatable {
  final int stepNumber;
  final String title;
  final String? timeOrStatus;
  final bool isCompleted;
  final bool isCurrent;
  final bool isCancelled;

  const OrderTimelineStepEntity({
    required this.stepNumber,
    required this.title,
    this.timeOrStatus,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isCancelled=false,
  });

  @override
  List<Object?> get props => [stepNumber, title, timeOrStatus, isCompleted, isCurrent, isCancelled];
}

class OrderEntity extends Equatable {
  final String id;
  final String providerName;
  final String profession;
  final String providerImage;
  final double rating;
  final int jobsCount;
  final OrderStatusType status;
  final String date;
  final String time;
  final String address;
  final String serviceName;
  final double baseRate;
  final double serviceFee;
  final String? cancelReason;
  final List<OrderTimelineStepEntity> timelineSteps;

  const OrderEntity({
    required this.id,
    required this.providerName,
    required this.profession,
    required this.providerImage,
    required this.rating,
    required this.jobsCount,
    required this.status,
    required this.date,
    required this.time,
    required this.address,
    required this.serviceName,
    required this.baseRate,
    required this.serviceFee,
    this.cancelReason,
    this.timelineSteps = const [],
  });

  double get total => baseRate + serviceFee;

  @override
  List<Object?> get props => [
        id,
        providerName,
        profession,
        providerImage,
        rating,
        jobsCount,
        status,
        date,
        time,
        address,
        serviceName,
        baseRate,
        serviceFee,
        cancelReason,
        timelineSteps,
      ];
}
