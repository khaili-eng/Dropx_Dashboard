// import 'package:dartz/dartz.dart';
// import 'package:maadati/core/error/exceptions.dart';
// import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
// import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';
// import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
// import 'package:maadati/features/promoCode/domain/repositories/promo_code_repositories.dart';

// class RepositoriesPromoCodeImpl extends PromoCodeRepositories {
//   final RemoteDataSorces remoteDataSorces;

//   RepositoriesPromoCodeImpl({required this.remoteDataSorces});
//   @override
//   Future<Either<ServerException, Unit>> addPromoCode(
//     PromoCodeEntitiy promoCode,
//   ) async {
//     final PromoCodeModel promoCodeModel = PromoCodeModel(status: , data: []
      
//     );
//     try {
//       await remoteDataSorces.addPromoCode(promoCodeModel);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerException("Failed to add promo code"));
//     }
//   }

//   @override
//   Future<Either<ServerException, Unit>> deletePromoCode(int promoCodeId) async {
//     try {
//       await remoteDataSorces.deletePromoCode(promoCodeId);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerException("Failed to add promo code"));
//     }
//   }

//   @override
//   Future<Either<ServerException, List<PromoCodeEntitiy>>> getPromoCode() async {
//     try {
//       final remoteData = await remoteDataSorces.getPromoCodes();
//       return Right(remoteData.cast<PromoCodeEntitiy>());
//     } on ServerException {
//       return Left(ServerException("Failed to fetch promo codes"));
//     }
//   }

//   @override
//   Future<Either<ServerException, Unit>> updatePromoCode(
//     PromoCodeEntitiy promoCode,
//   ) async {
//     final PromoCodeModel promoCodeModel = PromoCodeModel(
//       id: promoCode.id,
//       code: promoCode.code,
//     );
//     try {
//       await remoteDataSorces.updatePromoCode(promoCodeModel);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerException("Failed to add promo code"));
//     }
//   }
// }
