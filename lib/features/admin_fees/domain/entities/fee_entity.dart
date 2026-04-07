
import 'package:equatable/equatable.dart';

class FeeEntity extends Equatable{
  final bool status;
  final String date;
  final double total;

 const FeeEntity({
    required this.status,
    required this.date,
    required this.total,
  });
  
  @override
  List<Object?> get props => [status , date, total ];
}