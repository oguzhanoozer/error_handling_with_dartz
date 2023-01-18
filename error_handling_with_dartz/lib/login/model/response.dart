import 'package:dartz/dartz.dart';
import 'package:error_handling_with_dartz/login/model/error_model.dart';
import 'package:error_handling_with_dartz/login/model/response_model.dart';

class LoginResponse {
  late Either<ErrorModel, ResponseModel> response;

  LoginResponse(dynamic value) {
    if (value is ErrorModel) {
      response = Left(value);
    } else {
      response = Right(value);
    }
  }
}
