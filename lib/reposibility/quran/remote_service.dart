import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/core/statue_code_error.dart';
import 'package:quran_karim/model/error_result.dart';
import 'package:quran_karim/model/surah/surah.dart';
import 'package:quran_karim/reposibility/quran/resposibility.dart';
import 'package:quran_karim/utils/helper/dio_helper.dart';

class QuranRemoteService extends QuranRepository {
  @override
  Future<Either<List<Surah>, ErrorResult>> getQuranData() async {
    try {
      var response = await DioHelper.getData(url: 'quran/quran-uthmani');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data;
        List<dynamic> data = jsonMap['data']['surahs'];
        List<Surah> quranData = data.map((e) => Surah.formJson(e)).toList();
        return Left(quranData);
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
            errorImage: 'assets/icons/no-internet.png',
          ),
        );
      }
    }
  }
}
