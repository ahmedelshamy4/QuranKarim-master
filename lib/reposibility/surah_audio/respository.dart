import 'package:dartz/dartz.dart';

import '../../model/error_result.dart';
import '../../model/surah_audio.dart';

abstract class SurahAudioRepository {
  Future<Either<List<AyahAudio>, ErrorResult>> getSurahAudio(
      {required int surahId, required String elderFormat});
}
