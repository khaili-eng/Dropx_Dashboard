

import 'package:equatable/equatable.dart';
import 'package:maadati/features/customers/data/model/customer_model.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();
  @override
  List<Object?> get props => [];
}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersLoaded extends CustomersState {
  final List<CustomerModel> customers;
  final String? message;

  const CustomersLoaded(this.customers, {this.message} );

  @override
  List<Object?> get props => [customers,message];
}
class CustomerStatusUpdated extends CustomersState {
  final String? message;

  const CustomerStatusUpdated({this.message});

  @override
  List<Object?> get props => [message];
}

class CustomersError extends CustomersState {
  final String message;

  const CustomersError(this.message);

  @override
  List<Object?> get props => [message];
}