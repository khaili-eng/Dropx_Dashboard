import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';

abstract class RemoteDataSorces {
  Future<List<PromoCodeModel>> getPromoCodes();
  Future<Unit> addPromoCode(PromoCodeModel promoCode);
  Future<Unit> deletePromoCode(int id);
  Future<Unit> updatePromoCode(PromoCodeModel promoCode);
}

class RemoteDataSorcesImpl implements RemoteDataSorces {
  Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;
  String myToken = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";
  @override
  Future<Unit> addPromoCode(PromoCodeModel promoCode) {
    final body = {
      'code': promoCode.code,
      'discountType': promoCode.discountType,
      'discountValue': promoCode.discountValue,
      'minOrderValue': promoCode.minOrderValue,
      'maxUses': promoCode.maxUses,
      'expiryDate': promoCode.expiryDate.toIso8601String(),
    };
    try {
      dio.post(
        "$baseUrl/${ApiConstants.addPromoCodes}",
        data: body,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );
      return Future.value(unit);
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Unit> deletePromoCode(int id) {
    try {
      dio.delete(
        "$baseUrl/${ApiConstants.deletedPromoCodes}/$id",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );
      return Future.value(unit);
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PromoCodeModel>> getPromoCodes() async {
    String myToken = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";

    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getAllPromoCodes}",

        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => PromoCodeModel.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Unit> updatePromoCode(PromoCodeModel promoCode) {
    final body = {
      'code': promoCode.code,
      'discountType': promoCode.discountType,
      'discountValue': promoCode.discountValue,
      'minOrderValue': promoCode.minOrderValue,
      'maxUses': promoCode.maxUses,
      'expiryDate': promoCode.expiryDate.toIso8601String(),
    };
    try {
      dio.put(
        "$baseUrl/${ApiConstants.updatePromoCodes}/${promoCode.id}",
        data: body,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );
      return Future.value(unit);
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }
}


  

