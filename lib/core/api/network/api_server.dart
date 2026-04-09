import 'package:maadati/core/api/promo_code_aoi.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';

class ApiServer {
  final DioClient dioClient;
  ApiServer(this.dioClient);

  Future<void> add(PromoCode promo) async {
    try {
      final response = await dioClient.dio.post(
        "/AddPromoCode",
        data: promo.toJson(),
      );
    } catch (e) {
      throw e;
    }
  }
}
