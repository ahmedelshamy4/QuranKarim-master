import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../model/elder/elder.dart';
import '../../model/error_result.dart';

abstract class EldersRepository {
  Future<Either<List<Elder>, ErrorResult>> getElders(
      {required BuildContext context});
}
