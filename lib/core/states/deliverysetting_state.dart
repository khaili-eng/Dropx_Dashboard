abstract class DeliveryState {}

class DeliveryInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliverySuccess extends DeliveryState {
  final String message;
  DeliverySuccess(this.message);
}

class DeliveryError extends DeliveryState {
  final String error;
  DeliveryError(this.error);
}
