// ignore_for_file: public_member_api_docs, sort_constructors_first
 
import 'package:dio2/dio2.dart';

import 'package:fnrco_candidates/constants/enums.dart';
import 'package:fnrco_candidates/constants/responses_code.dart';
import 'package:fnrco_candidates/core/classes/extensions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';

class ApiException implements Exception {
  Failure failure;
  ApiException({
    required this.failure,
  });
  
}








class APIErrorHandler implements Exception {
  late Failure failure;

  APIErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }
}


//////////////// TODO: handling All steps 

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.SEND_TIMEOUT:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.RECEIVE_TIMEOUT:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.RESPONSE:
        return _handleBadResponse(error);
      case DioErrorType.CANCEL:
        return DataSource.cancel.getFailure();
      case DioErrorType.DEFAULT:
        return DataSource.connectionError.getFailure();
      default:
        return _handleDefaultError(error);
    }
  }

  _handleBadResponse(DioError error) {
    try {
      final code = error.response?.statusCode ?? ResponseCode.defaultError;
      String message = '';
      switch (code) {
        case ResponseCode.unauthorised:
          return DataSource.unauthorised.getFailure();
        case ResponseCode.forbidden:
          return DataSource.forbidden.getFailure();
          case ResponseCode.badRequest:
          return DataSource.badRequest.getFailure();
        case ResponseCode.notFound:
          return DataSource.notFound.getFailure();
        default:
          message = _extractErrorMessage(error.response?.data);
          return Failure(code, message);
      }
    } catch (e) {
      return DataSource.defaultError.getFailure();
    }
  }

  _handleDefaultError(DioError error) {
    if (error.response?.statusCode == ResponseCode.noInternetConnection) {
      return DataSource.noInternetConnection.getFailure();
    } else {
      return DataSource.defaultError.getFailure();
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is String) return data;
    String message = '';
    if (data is Map) {
      data.forEach((key, value) {
        if (value is List) {
          message += value.join('\n');
        } else if (value is String) {
          message += value;
        } else {
          message += value.toString();
        }
      });
    }
    return message;
  }