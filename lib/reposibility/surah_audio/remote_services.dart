import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/model/error_result.dart';
import 'package:quran_karim/reposibility/surah_audio/respository.dart';
import 'package:quran_karim/utils/helper/dio_helper.dart';
import '../../core/statue_code_error.dart';
import '../../model/surah_audio.dart';

class SurahAudioRemoteService extends SurahAudioRepository {
  @override
  Future<Either<List<AyahAudio>, ErrorResult>> getSurahAudio(
      {required int surahId, required String elderFormat}) async {
    try {
      var response =
          await DioHelper.getData(url: 'surah/$surahId/$elderFormat');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        List<dynamic> data = jsonData['data']['ayahs'];
        List<AyahAudio> surahAudio =
            data.map((e) => AyahAudio.fromJson(e)).toList();
        return Left(surahAudio);
      } else {
        return Right(returnResponse(response));
      }
    } on DioError catch (dioException) {
      if (dioException.type == DioErrorType.response) {
        return Right(returnResponse(dioException.response!));
      } else {
        return Right(
          ErrorResult(
              errorMessage: 'error'.tr(),
              errorImage: 'assets/icons/no-internet.png'),
        );
      }
    }
  }
}
