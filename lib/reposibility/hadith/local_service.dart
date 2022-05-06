import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/model/error_result.dart';
import 'package:quran_karim/model/hadith/Hadith.dart';
import 'package:quran_karim/reposibility/hadith/respository.dart';

class AhadithLocalService extends AhadithRepository {
  @override
  Future<Either<List<Hadith>, ErrorResult>> getAhadith(
      {required BuildContext context}) async {
    try {
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json_db/hadith.json');
      List<dynamic> jsonData = jsonDecode(response);
      List<Hadith> ahadithList =
          jsonData.map((e) => Hadith.fromJson(e)).toList();
      return Left(ahadithList);
    } catch (exception) {
      ErrorResult error = ErrorResult(
          errorMessage: 'local_exception'.tr(),
          errorImage: 'assets/icons/storage_error.png');
      return Right(error);
    }
  }
}
