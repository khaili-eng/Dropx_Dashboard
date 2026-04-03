import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:maadati/core/constants/end_points/end_points.dart';
import 'package:maadati/core/network/api/api_error.dart';
import 'package:maadati/core/network/api/api_exceptions.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/advertesment/data/model/adv_model.dart';
import 'package:maadati/features/advertesment/repo/adv_repo.dart';

class AdvRepoImpl implements AdvRepo{
  final ApiService apiService;
  AdvRepoImpl(this.apiService);
  @override
  Future<AdvModel>createAd({
     required String title,
     required String description,
     required Uint8List imageBytes,
     required String fileName,
})async{
    try{
      FormData formData = FormData.fromMap({
        "title":title,
        "description":description,
        "image":await MultipartFile.fromBytes(
          imageBytes as List<int> ,
          filename: fileName
        )
      });
      final response = await apiService.postFormData(EndPoints.createAdv, formData);
      return AdvModel.fromJson(response['data']);
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
  }
  @override
  Future<List<AdvModel>>getAllAdv()async {
    try{
final response = await apiService.get(EndPoints.getAllAdv);
List advs = response;
return advs.map((e)=>AdvModel.fromJson(e)).toList();
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
  }
  @override
  Future<AdvModel>updateAdv({
    required int id,
    required String title,
    required String description,
    Uint8List? imageBytes,
    String? fileName,})async{
    try{
     FormData formData = FormData.fromMap(({
       "title":title,
       "description":description,
       if(imageBytes!=null&&fileName!=null)
         'image':MultipartFile.fromBytes(imageBytes,filename: fileName),
     }));
     final response = await apiService.putFormData(EndPoints.updateAdv(id), formData);
     return AdvModel.fromJson(response['ad']);
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
  }
}