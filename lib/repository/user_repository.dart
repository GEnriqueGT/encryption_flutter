import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/resources/constants.dart';


class UserRepository {
  static const String token = 'token';

  final FlutterSecureStorage storage;

  UserRepository() : storage = const FlutterSecureStorage();

  Future<String> getToken() async {
    return (await storage.read(key: token)) ?? emptyString;
  }

  Future<void> setToken(final String newToken) async {
    await storage.write(
      key: token,
      value: newToken,
    );
  }
}
