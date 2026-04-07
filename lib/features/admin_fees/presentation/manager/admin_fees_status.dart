import 'package:equatable/equatable.dart';
import 'package:maadati/features/admin_fees/data/model/admin_fee.dart';

class AdminFeesStatus extends Equatable {
  const AdminFeesStatus();
  @override

  List<Object?> get props => [];
}

class AdminFeesInitial extends AdminFeesStatus{}


class AdminFeesLoading extends AdminFeesStatus {}

class AdminFeesLodded extends AdminFeesStatus {
  final List<FeeModel> adminFees;
 const AdminFeesLodded({required this.adminFees});
   @override
  List<Object?> get props => [adminFees];
}
class AdminFeesError extends AdminFeesStatus {
  final String error;
const  AdminFeesError({required this.error});
@override
  List<Object?> get props => [error];


}

