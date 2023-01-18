import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:error_handling_with_dartz/login/model/error_model.dart';
import 'package:error_handling_with_dartz/login/model/login_model.dart';
import 'package:error_handling_with_dartz/login/model/response_model.dart';
import 'package:error_handling_with_dartz/network/network_manager.dart';

import '../model/response.dart';

abstract class ILoginService {
  final Dio _dio;

  ILoginService(this._dio);

  Future<Either<loginFailure, ResponseModel>> login(LoginModel loginModel);
  Future<LoginResponse> loginTwo(LoginModel loginModel);
}

enum loginFailure { invalidCredentials, error }

extension loginFailureExtension on loginFailure {
  String get rawValue {
    switch (this) {
      case loginFailure.error:
        return "An unknown error occured";

      case loginFailure.invalidCredentials:
        return "An error occured because of wrong or missing user information";

      default:
        throw "Any message not found";
    }
  }
}

class LoginService extends ILoginService {
  LoginService(super.dio);

  @override
  Future<Either<loginFailure, ResponseModel>> login(
      LoginModel loginModel) async {
    final _requestBody = {
      "email": loginModel.email,
      "password": loginModel.password
    };

    try {
      final _response =
          await _dio.post(servicePath.login.rawValue, data: _requestBody);

      if (_response.statusCode == HttpStatus.ok) {
        final _responseModel = ResponseModel.fromJson(_response.data);
        return Right(_responseModel);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.badRequest) {
        return const Left(loginFailure.invalidCredentials);
      }
    }
    return const Left(loginFailure.error);
  }

  @override
  Future<LoginResponse> loginTwo(LoginModel loginModel) async {
    final _requestBody = {
      "email": loginModel.email,
      "password": loginModel.password
    };

    try {
      final _response =
          await _dio.post(servicePath.login.rawValue, data: _requestBody);

      if (_response.statusCode == HttpStatus.ok) {
        final _responseModel = ResponseModel.fromJson(_response.data);
        return LoginResponse(_responseModel);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.badRequest) {
        return LoginResponse(
            ErrorModel(errorMessage: loginFailure.invalidCredentials.rawValue));
      }
    }
    return LoginResponse(ErrorModel(errorMessage: loginFailure.error.rawValue));
  }
}
