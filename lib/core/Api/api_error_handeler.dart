import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_ai/core/Api/local_status_code.dart';

abstract class Failure {
  final String errMessage;
  final IconData errIcon;
  final int statusCode;

  Failure({
    required this.errIcon,
    required this.statusCode,
    required this.errMessage,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.errIcon,
    required super.statusCode,
    required super.errMessage,
  });

  factory ServerFailure.fromdioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errMessage: 'Connection timeout',
          errIcon: Icons.timer_off,
          statusCode: LocalStatusCode.connectionTimeout,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errMessage: 'Send timeout',
          errIcon: Icons.send_time_extension,
          statusCode: LocalStatusCode.sendTimeout,
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errMessage: 'Receive timeout',
          errIcon: Icons.schedule,
          statusCode: LocalStatusCode.receiveTimeout,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          errMessage: 'Bad SSL Certificate',
          errIcon: Icons.security,
          statusCode: LocalStatusCode.badCertificate,
        );

      case DioExceptionType.badResponse:
        return ServerFailure(
          errMessage: 'Something went wrong. Please try again later.',
          errIcon: Icons.warning,
          statusCode:
              dioException.response?.statusCode ?? LocalStatusCode.badResponse,
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          errMessage: 'Request was canceled',
          errIcon: Icons.cancel,
          statusCode: LocalStatusCode.cancel,
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          errMessage: 'No Internet Connection',
          errIcon: Icons.wifi_off,
          statusCode: LocalStatusCode.connectionError,
        );

      default:
        return ServerFailure(
          errMessage: 'Unknown Error, Please try again later!',
          errIcon: Icons.error_outline,
          statusCode: LocalStatusCode.unknown,
        );
    }
  }
}
