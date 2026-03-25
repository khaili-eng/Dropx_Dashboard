import 'package:bloc/bloc.dart';
import 'package:maadati/features/customers/repo/customer_repo.dart';

import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final CustomerRepo customerRepo;

  CustomersCubit(this.customerRepo) : super(CustomersInitial());
  //function for get all customers
  Future<void> getAllCustomers() async {
    print("START FETCH");
    emit(CustomersLoading());
    try {
      final customers = await customerRepo.getAllCustomers();
      print("DATA RECEIVED: $customers");
      emit(CustomersLoaded(customers!));
    } catch (e) {
      emit(CustomersError(e.toString()));
    }
  }

  //function for update user activation
  Future<void> updateUserActivation(int userId) async {
    try {
      final response = await customerRepo.updateUserActivation(userId);

      if (state is CustomersLoaded) {
        final currentState = state as CustomersLoaded;

        final updatedList =
            currentState.customers.map((user) {
              if (user.id == userId) {
                return user.copyWith(isActive: response.isActive);
              }
              return user;
            }).toList();

        emit(CustomersLoaded(updatedList, message: response.message));
      }
    } catch (e) {
      emit(CustomersError(e.toString()));
    }
  }
}
