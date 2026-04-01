// import 'package:maadati/features/order/data/model/order_det_model.dart';

// class OrderDetState {}

// class OrderDetInitial extends OrderDetState {}

// class OrderDetLoading extends OrderDetState {}
// class OrderDetSuccess extends OrderDetState {
//   final List<OrderData> orderDet;
//   OrderDetSuccess(this.orderDet);
// }

// class OrderDetError extends OrderDetState {
//   final String message;
//   OrderDetError(this.message);
// }


import 'package:maadati/features/order_det/data/model/order_det_model.dart';

abstract class OrderDetState {}

class OrderDetInitial extends OrderDetState {}

class OrderDetLoading extends OrderDetState {}

class OrderDetSuccess extends OrderDetState {
  final OrderData order;
  OrderDetSuccess(this.order);
}

class OrderError extends OrderDetState {
  final String message;
  OrderError(this.message);
}