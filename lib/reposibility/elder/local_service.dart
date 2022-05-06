import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/model/elder/elder.dart';
import 'package:quran_karim/model/error_result.dart';
import 'package:quran_karim/reposibility/elder/repository.dart';

class EldersLocalService extends EldersRepository {
  @override
  Future<Either<List<Elder>, ErrorResult>> getElders(
      {required BuildContext context}) async {
    try {
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json_db/elders.json');
      List<dynamic> jsonData = jsonDecode(response);
      List<Elder> elders = jsonData.map((e) => Elder.fromJson(e)).toList();
      return Left(elders);
    } catch (exception) {
      ErrorResult error = ErrorResult(
          errorMessage: 'local_exception'.tr(),
          errorImage: 'assets/icons/storage_error.png');
      return Right(error);
    }
  }
}
