import 'package:dartz/dartz.dart';
import 'package:quran_karim/model/error_result.dart';
import 'package:quran_karim/model/surah/surah.dart';

abstract class QuranRepository {
  Future<Either<List<Surah>, ErrorResult>> getQuranData();
}
