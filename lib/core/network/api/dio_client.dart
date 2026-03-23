import 'package:dio/dio.dart';

import '../../utils/pref_helper.dart';
//every thing we need to dio package
class DioClient{
final Dio _dio = Dio(
  BaseOptions(
   baseUrl: "http://127.0.0.1:8000/api",
   headers: {
     "Content-Type":'application/json',
     "Accept":'application/json',
   },
  )
);
DioClient(){
  _dio.interceptors.add(
   InterceptorsWrapper(
     onRequest: (option,handler)async{
       final token =await PrefHelper.getToken();
       if(token != null && token.isNotEmpty){
         option.headers["Authorization"] = "Bearer $token";
       }
        handler.next(option);
     }
   )
  );
}
Dio get dio => _dio;
}