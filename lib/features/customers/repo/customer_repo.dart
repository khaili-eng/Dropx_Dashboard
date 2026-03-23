import 'package:maadati/features/customers/data/model/customer_model.dart';
import 'package:maadati/features/customers/data/model/update_user_status_response.dart';

abstract class CustomerRepo{
  Future<List<CustomerModel>?>getAllCustomers();
  Future<UpdateUserStatusResponse>updateUserActivation(int userId);
}