import 'package:maadati/features/models/commissionModel/commission_model.dart';

abstract class CommissionState {}

class CommissionInitial extends CommissionState {}

class CommissionLoading extends CommissionState {}

class CommissionSuccess extends CommissionState {
  final CommissionModel commission;

  CommissionSuccess(this.commission);
}

class CommissionError extends CommissionState {
  final String message;

  CommissionError(this.message);
}
