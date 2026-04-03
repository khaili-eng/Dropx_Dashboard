import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/advertesment/presentation/manager/adv_state.dart';
import 'package:maadati/features/advertesment/repo/adv_repo.dart';

class AdvCubit extends Cubit<AdvState>{
  final AdvRepo advRepo;
  AdvCubit(this.advRepo):super(AdvInitial());
  //create adv
Future<void>createAd({
    required String title,
  required String description,
  required Uint8List imageBytes,
  required String fileName,
})async{
  emit(AdvLoading());
  try{
    final adv= await advRepo.createAd(title: title, description: description,imageBytes: imageBytes,fileName: fileName);
    emit(AdvSuccess(advModel: adv, message: "تم إضافة الاعلان بنجاح "));
    getAllAdv();
  }catch(e){
emit(AdvError(e.toString()));
  }
}
//get all advs
Future<void>getAllAdv()async{
  emit(AdvLoading());
  try{
    final advs = await advRepo.getAllAdv();
    emit(AdvLoaded(advs));
  }catch(e){
emit(AdvError(e.toString()));
  }
}
//update advs
Future<void> updateAdv({
    required int id,
  required String title,
  required String description,
  Uint8List?imageBytes,
  String?fileName,
})async{
  emit(UpdateAdvLoading());
  try{
    final ad = await advRepo.updateAdv(
        id: id,
        title: title,
        description: description,
      imageBytes: imageBytes,
      fileName: fileName
    );
    emit(AdvUpdateSuccess(ad: ad, message: "تم تعديل الإعلان بنجاح "));
    getAllAdv();
  }catch(e){
      emit(AdvUpdateError(e.toString()));
  }
}
}