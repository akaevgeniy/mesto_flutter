import 'package:mesto_flutter/data/models/auth_user.dart';
import 'package:mesto_flutter/data/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  AuthUser user;
  UserRepository(this.user);

  final _storage = const FlutterSecureStorage();

  Future<void> setUserRegister(bool isRegister) async {
    user.isRegister = isRegister;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userIsRegister', isRegister);
  }

  Future<bool?> isUserRegister() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? userIsRegister = prefs.getBool('userIsRegister');
    return userIsRegister;
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> setUserToken(String token) async {
    var writeToken = await _storage.write(
      key: 'token',
      value: token,
    );
    return writeToken;
  }

  Future<String?> readUserToken() async {
    var readToken = await _storage.read(key: 'token');
    return readToken;
  }

  Future<void> deleteUserToken() async {
    _storage.delete(key: 'token');
  }
}

class UserProfile {
  Profile user;
  UserProfile(this.user);

  static empty() => Profile(email: '');
}
