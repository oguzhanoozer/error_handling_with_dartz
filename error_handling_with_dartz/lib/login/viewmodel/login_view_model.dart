import 'package:dio/dio.dart';
import 'package:error_handling_with_dartz/login/model/login_model.dart';
import 'package:error_handling_with_dartz/login/service/login_service.dart';
import 'package:error_handling_with_dartz/network/network_manager.dart';

class LoginViewModel {
  LoginViewModel() {
    _loginService = LoginService(_dio);
  }
  final Dio _dio = NetworkManager.instance.dio;
  late LoginService _loginService;

  Future<void> login() async {
    final LoginModel _loginModel =
        LoginModel(email: "eve.holt@reqres.in", password: "cityslicka");

    final _result = await _loginService.login(_loginModel);
    _result.fold((l) {
      if (l == loginFailure.error) {
        print("An error occured while logging");
      } else if (l == loginFailure.invalidCredentials) {
        print("An error occured because of wrong user information");
      }
    }, (r) {
      print("Token: " + r.token.toString());
    });
  }

  Future<void> loginTwo() async {
    final LoginModel _loginModel =
        LoginModel(email: "eve.holt@reqres.in", password: "");

    final _result = await _loginService.loginTwo(_loginModel);
    _result.response.fold((l) {
      print(l.errorMessage);
    }, (r) {
      print("Token: " + r.token.toString());
    });
  }
}
