import 'dart:typed_data';

import 'package:maadati/features/advertesment/data/model/adv_model.dart';

abstract class AdvRepo{
  //create adv
  Future<AdvModel>createAd({
    required String title,
    required String description,
    required Uint8List imageBytes,
    required String fileName
  });
  //get all Adv
  Future<List<AdvModel>>getAllAdv();
  //update adv
  Future<AdvModel>updateAdv({
    required int id,
    required String title,
    required String description,
    Uint8List? imageBytes,
    String? fileName,
});
}