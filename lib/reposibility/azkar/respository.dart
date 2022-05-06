import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_karim/model/azkar/azkar_category.dart';
import 'package:quran_karim/model/azkar/azkar_details.dart';

import '../../model/error_result.dart';

abstract class AzkarRepository {
  Future<Either<List<AzkarCategory>, ErrorResult>> getAzkarCategories(
      {required BuildContext context});

  Future<Either<List<AzkarDetails>, ErrorResult>> getAzkarDetails(
      {required BuildContext context, required int categoryId});
}
