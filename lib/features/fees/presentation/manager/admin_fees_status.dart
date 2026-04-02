import 'package:maadati/features/fees/data/model/admin_fee.dart';

class AdminFeesStatus {}

class AdminFeesInitial extends AdminFeesStatus {}

class AdminFeesLoading extends AdminFeesStatus {}

class AdminFeesSuccess extends AdminFeesStatus {
  final AdminFee adminFeeData; 
  AdminFeesSuccess(this.adminFeeData);
}

class AdminFeesError extends AdminFeesStatus {
  final String message;
  AdminFeesError(this.message);
}
