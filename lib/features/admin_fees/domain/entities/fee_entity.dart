
import 'package:equatable/equatable.dart';

class FeeEntity extends Equatable{
  final bool status;
  final String date;
  final double total;

  FeeEntity({
    required this.status,
    required this.date,
    required this.total,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [status , date, total ];
}