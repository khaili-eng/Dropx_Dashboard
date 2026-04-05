import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/deliverysetting_api.dart';
import 'package:maadati/core/states/deliverysetting_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  final DeliverySettingApi apiService;

  DeliveryCubit(this.apiService) : super(DeliveryInitial());

  Future<void> updateDeliverySettings({
    required String token,
    required double pricePerKm,
    required double minimumDeliveryFee,
  }) async {
    emit(DeliveryLoading());

    try {
      final response = await apiService.updateDeliverySettings(
        token: token,
        pricePerKm: pricePerKm,
        minimumDeliveryFee: minimumDeliveryFee,
      );

      emit(DeliverySuccess(response.data.toString()));
    } catch (e) {
      emit(DeliveryError(e.toString()));
    }
  }
}
