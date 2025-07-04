
import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout. Please try again later.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Unable to connect to the server. Please try again.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Server took too long to respond.');
      case DioExceptionType.badCertificate:
        return ServerFailure('Security certificate error. Please try again later.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled.');
      case DioExceptionType.connectionError:
        return ServerFailure('Please Kindly Check your internet.');
      case DioExceptionType.unknown:
        if (dioError.message != null && dioError.message!.contains('SocketException')) {
          return ServerFailure('No internet connection. Please check your network.');
        }
        return ServerFailure('An unknown error occurred. Please try again.');
      }
  }

factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 422) {
      return ServerFailure('Invalid credentials. Please check your email and password.');
    } else if (statusCode == 404) {
      return ServerFailure('Requested resource not found.');
    } else if (statusCode == 500) {
      return ServerFailure('Server error. Please try again later.');
    } else {
      return ServerFailure('Unexpected error occurred. Please try again.');
    }
  }

}