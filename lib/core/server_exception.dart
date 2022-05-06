import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quran_karim/model/error_result.dart';

abstract class ServerException {
  ErrorResult errorResult();
}

class BadRequestException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
      errorMessage: 'error'.tr(),
      errorImage: 'assets/icons/server.png',
    );
  }
}

class UnauthorisedException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        errorMessage: 'error'.tr(), errorImage: 'assets/icons/server.png');
  }
}

class FetchDataException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        errorMessage: 'error'.tr(), errorImage: 'assets/icons/server.png');
  }
}
