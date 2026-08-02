import 'package:servix/features/order/domain/entites/order_entity.dart';

class OrderTimelineStepModel extends OrderTimelineStepEntity {
  const OrderTimelineStepModel({
    required super.stepNumber,
    required super.title,
    super.timeOrStatus,
    super.isCompleted = false,
    super.isCurrent = false,
  });

  factory OrderTimelineStepModel.fromJson(Map<String, dynamic> json) {
    return OrderTimelineStepModel(
      stepNumber: json['step_number'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      timeOrStatus: json['time_or_status'] as String?,
      isCompleted: json['is_completed'] as bool? ?? false,
      isCurrent: json['is_current'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step_number': stepNumber,
      'title': title,
      'time_or_status': timeOrStatus,
      'is_completed': isCompleted,
      'is_current': isCurrent,
    };
  }
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.providerName,
    required super.profession,
    required super.providerImage,
    required super.rating,
    required super.jobsCount,
    required super.status,
    required super.date,
    required super.time,
    required super.address,
    required super.serviceName,
    required super.baseRate,
    required super.serviceFee,
    super.cancelReason,
    super.timelineSteps = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      providerName: json['provider_name'] as String? ?? '',
      profession: json['profession'] as String? ?? '',
      providerImage: json['provider_image'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      jobsCount: json['jobs_count'] as int? ?? 0,
      status: _parseStatus(json['status'] as String?),
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      address: json['address'] as String? ?? '',
      serviceName: json['service_name'] as String? ?? '',
      baseRate: (json['base_rate'] as num?)?.toDouble() ?? 0.0,
      serviceFee: (json['service_fee'] as num?)?.toDouble() ?? 4.99,
      cancelReason: json['cancel_reason'] as String?,
      timelineSteps: (json['timeline_steps'] as List<dynamic>?)
              ?.map((e) => OrderTimelineStepModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  static OrderStatusType _parseStatus(String? statusStr) {
    switch (statusStr?.toLowerCase()) {
      case 'completed':
        return OrderStatusType.completed;
      case 'cancelled':
      case 'canceled':
        return OrderStatusType.cancelled;
      case 'pending':
      default:
        return OrderStatusType.pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_name': providerName,
      'profession': profession,
      'provider_image': providerImage,
      'rating': rating,
      'jobs_count': jobsCount,
      'status': status.name,
      'date': date,
      'time': time,
      'address': address,
      'service_name': serviceName,
      'base_rate': baseRate,
      'service_fee': serviceFee,
      'cancel_reason': cancelReason,
      'timeline_steps': timelineSteps
          .map((e) => (e is OrderTimelineStepModel)
              ? e.toJson()
              : OrderTimelineStepModel(
                  stepNumber: e.stepNumber,
                  title: e.title,
                  timeOrStatus: e.timeOrStatus,
                  isCompleted: e.isCompleted,
                  isCurrent: e.isCurrent,
                ).toJson())
          .toList(),
    };
  }
}
