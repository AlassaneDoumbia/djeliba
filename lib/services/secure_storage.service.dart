import 'package:djeliba/models/auth.model.dart';
import 'package:djeliba/models/auth_data.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


const accessToken = "access_token";
const id = "user_id";
const phone = "phone";
const fullName = "full_name";
const lastName = "last_name";


class SecureStorageService {
  final _storage = FlutterSecureStorage(
    iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),
  );

  static IOSOptions _getIOSOptions() => const IOSOptions();

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<void> storeAuthData(Auth auth) async {
    // print("storeAuthData ::::: ${auth}");
    // print("storeAuthData ::::: ${auth.phone}");
    // print("storeAuthData ::::: ${auth.accessToken}");
    await _storage.write(key: accessToken, value: auth.accessToken);
    await _storage.write(key: id, value: auth.userId);
    await _storage.write(key: phone, value: auth.phone);
    await _storage.write(key: fullName, value: "${auth.firstname} ${auth.lastname}");
    await _storage.write(key: lastName, value: auth.lastname);
  }

  Future<AuthData> getAuthData() async {
    final map = await _storage.readAll();

    return AuthData(accessToken: map[accessToken], id: map[id],
        phone: map[phone], fullName: map[fullName], lastName: map[lastName]);
  }

  Future<String> getAuthToken() async {
    final map = await _storage.readAll();

    return map[accessToken]!;
  }

  Future<void> updateAccessToken(String token) async {
    await _storage.delete(key: accessToken);
    await _storage.write(key: accessToken, value: token);
  }

  // Future<void> updateRefreshToken(String token) async {
  //   await _storage.write(key: refreshToken, value: token);
  // }

  Future<void> clearAuthData() async {
    await _storage.deleteAll();
  }
}