import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../model/error_result.dart';
import '../../model/hadith/Hadith.dart';

abstract class AhadithRepository {
  Future<Either<List<Hadith>, ErrorResult>> getAhadith(
      {required BuildContext context});
}
