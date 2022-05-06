import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:quran_karim/model/assmaa_allah.dart';

import 'package:quran_karim/model/error_result.dart';

import 'respository.dart';

class AssmaaAllahLocalService extends AssmaaAllahRepository {
  @override
  Future<Either<List<AssmaaAllah>, ErrorResult>> getAssmaaAllahAlhosna(
      {required BuildContext context}) async {
    try {
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json_db/asmaa_allah_alhosna.json');
      List<dynamic> jsonData = jsonDecode(response);
      List<AssmaaAllah> assmaaAllahList =
          jsonData.map((e) => AssmaaAllah.fromJson(e)).toList();
      return Left(assmaaAllahList);
    } catch (exception) {
      ErrorResult error = ErrorResult(
          errorMessage: 'local_exception'.tr(),
          errorImage: 'assets/icons/storage_error.png');
      return Right(error);
    }
  }
}
