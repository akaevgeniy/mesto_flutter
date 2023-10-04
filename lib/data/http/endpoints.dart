import 'package:mesto_flutter/constants/string_constants.dart';

class Endpoints {
  Endpoints._();

  static const String baseUrl = kBaseURL;
  static const Duration receiveTimeout = Duration(seconds: 7);
  static const Duration connectionTimeout = Duration(seconds: 7);

  static const String auth = '/api/auth/';
  static const String register = '${auth}register';
  static const String logout = '${auth}logout';
}
