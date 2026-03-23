import 'package:dio/dio.dart';
import 'package:maadati/core/constants/end_points/end_points.dart';
import 'package:maadati/core/network/api/api_error.dart';
import 'package:maadati/core/network/api/api_exceptions.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/customers/data/model/customer_model.dart';
import 'package:maadati/features/customers/data/model/update_user_status_response.dart';
import 'package:maadati/features/customers/repo/customer_repo.dart';

class CustomerRepoImpl implements CustomerRepo{
  final ApiService apiService;
  CustomerRepoImpl(this.apiService);
  
  //get all customers
Future<List<CustomerModel>?>getAllCustomers()async{
  try{
    final response = await apiService.get(EndPoints.customers);
    if(response['status']==true&&response['data']!=null){
      List users = response['data'];
      return users.map((e)=>CustomerModel.fromJson(e)).toList();
    }else{
      throw ApiError(message: "Invalid response from server");
    }
  }on DioException catch(e){
    throw ApiExceptions.handleError(e);
  }catch(e){
    throw ApiError(message: e.toString());
  }
}
//update user status response
Future<UpdateUserStatusResponse> updateUserActivation(int userId)async{
  try{
   final response = await apiService.post(EndPoints.updateUserStatus(userId), {}
   );
   return UpdateUserStatusResponse.fromJson(response);
  }on DioException catch(e){
    throw ApiExceptions.handleError(e);
  }catch(e){
    throw ApiError(message: e.toString());
  }
}
}