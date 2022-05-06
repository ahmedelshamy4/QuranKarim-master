import 'package:dio/dio.dart';
import 'package:quran_karim/core/server_exception.dart';
import 'package:quran_karim/model/error_result.dart';

ErrorResult returnResponse(Response response) {
  switch (response.statusCode) {
    case 400:
      return BadRequestException().errorResult();
    case 401:
    case 403:
      return UnauthorisedException().errorResult();
    case 404:
    case 500:
    case 503:
    default:
      return FetchDataException().errorResult();
  }
}
