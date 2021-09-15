import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:interview_testing/common/constants/alert_message.dart';
import 'package:interview_testing/common/constants/app_config.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/data/network/result.dart';
import 'package:interview_testing/common/service/navigation_service.dart';
import 'package:interview_testing/common/service/toast_service.dart';
import 'package:interview_testing/common/constants/app_utils.dart';

typedef EntityMapper<Entity, Model> = Model Function(Entity entity);

abstract class _ErrorCode {
  static const message = "message";
  static const errors = "errors";
  static const unauthorized = "unauthorized";
}

abstract class BaseRepository {
  final String _apiEndpoint = AppConfig.BASE_URL;
  // final ToastService _toastService = locator<ToastService>();
  // final NavigationService _navigationService = locator<NavigationService>();
  final AppUtils _appUtils = locator<AppUtils>();

  Future<Map<String, String>> _getHeaders() async {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }

  Future<Dio> get dio => _getDio();

  Future<Dio> _getDio() async {
    final dio = Dio();
    final headers = await _getHeaders();
    dio.options = new BaseOptions(
      baseUrl: _apiEndpoint,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      headers: headers,
      followRedirects: false,
    );
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        responseHeader: false,
        requestHeader: true,
        logPrint: (object) => debugPrint(object.toString()),
        request: true));
    return dio;
  }

  Future<Result<T>> safeCall<T>(Future<T> call) async {
    try {
      var response = await call;
      print('Base Repository: API successful!');
      return Success(response);
    } catch (exception, stackTrace) {
      print('Base Repository: API failure --> $exception');
      print('Base Repository: API stacktrace --> $stackTrace');
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.cancel:
            return Error(AlertMessages.TIMEOUT_ERROR_MSG);

          case DioErrorType.other:
            return Error(AlertMessages.OFFLINE_ERROR_MSG);

          case DioErrorType.response:
            // return _getError(exception.response);

          default:
            return Error(AlertMessages.GENERIC_ERROR_MSG);
        }
      }
      return Error(AlertMessages.GENERIC_ERROR_MSG);
    }
  }

/*  Future<Result<T>> _getError<T>(Response? response) async {
    if (response?.data != null && response?.data is Map<String, dynamic>) {
      if ((response!.data as Map<String, dynamic>)
          .containsKey(_ErrorCode.message)) {
        print("Api error response -> ${response.data.toString()}");
        var errorMessage = response.data[_ErrorCode.message] as String;
        if(response.data[_ErrorCode.errors] != null && (response.data[_ErrorCode.errors] as List<dynamic>) != null && (response.data[_ErrorCode.errors] as List<dynamic>).length > 0) {
          errorMessage = (response.data[_ErrorCode.errors] as List<dynamic>)[0][_ErrorCode.message];
        }
        if (errorMessage.toLowerCase() == _ErrorCode.unauthorized.toLowerCase()) {
          /// show session expired toast
          _toastService.show(AlertMessages.SESSION_EXPIRED);

          /// logout user and navigate user to login screen
          await _navigationService.logout();

          /// return
          return Error(errorMessage);
        }
        return Error(errorMessage);
      }
    }
    return Error(
      AlertMessages.GENERIC_ERROR_MSG,
    );
  }*/
}
