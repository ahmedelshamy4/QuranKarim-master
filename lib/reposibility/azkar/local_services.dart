import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/model/azkar/azkar_category.dart';
import 'package:quran_karim/model/azkar/azkar_details.dart';
import 'package:quran_karim/model/error_result.dart';
import 'package:quran_karim/reposibility/azkar/respository.dart';

class AzkarLocalService extends AzkarRepository {
  @override
  Future<Either<List<AzkarCategory>, ErrorResult>> getAzkarCategories(
      {required BuildContext context}) async {
    try {
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json_db/azkar_category.json');
      List<dynamic> jsonData = jsonDecode(response);
      List<AzkarCategory> categories =
          jsonData.map((e) => AzkarCategory.formJson(e)).toList();
      return Left(categories);
    } catch (exception) {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'local_exception'.tr(),
          errorImage: 'assets/icons/storage_error.png');
      return Right(errorResult);
    }
  }

  @override
  Future<Either<List<AzkarDetails>, ErrorResult>> getAzkarDetails(
      {required BuildContext context, required int categoryId}) async {
    try {
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json_db/azkar_category_details.json');
      List<dynamic> jsonData = jsonDecode(response);
      List<AzkarDetails> details =
          jsonData.map((e) => AzkarDetails.fromJson(e)).toList();
      return Left(details);
    } catch (exception) {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'local_exception'.tr(),
          errorImage: 'assets/icons/storage_error.png');
      return Right(errorResult);
    }
  }
}
