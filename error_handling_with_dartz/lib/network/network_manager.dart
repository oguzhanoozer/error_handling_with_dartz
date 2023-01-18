import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  late Dio dio;
  final _baseUrl = "https://reqres.in/api/";
  NetworkManager._init() {
    dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }
}

enum servicePath { login }

extension servicePathExtension on servicePath {
  String get rawValue {
    switch (this) {
      case servicePath.login:
        return "login";

      default:
        throw "Not found any service Path";
    }
  }
}
