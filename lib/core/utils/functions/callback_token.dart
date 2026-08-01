import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_enums.dart';
import '../constants/storage_keys.dart';

class HandleMulticallLocal {
  static const _storage = FlutterSecureStorage();

  String? _accessToken;
  String? _refreshToken;
  String? _userId;
  String? _languageCode;
  String? _role;

  Future<void> saveLocalData({
    required String? data,
    required LocalEnumKey keyType,
  }) async {
    switch (keyType) {
      case LocalEnumKey.accessToken:
        _accessToken = data;
        await _storage.write(key: StorageKeys.accessToken, value: data);
        break;

      case LocalEnumKey.refreshToken:
        _refreshToken = data;
        await _storage.write(key: StorageKeys.refreshToken, value: data);
        break;

      case LocalEnumKey.userId:
        _userId = data;
        await _storage.write(key: StorageKeys.userId, value: data);
        break;
      case LocalEnumKey.fullName:
        await _storage.write(key: StorageKeys.userName, value: data);
        break;
      case LocalEnumKey.phone:
        await _storage.write(key: StorageKeys.userPhone, value: data);
        break;
      case LocalEnumKey.gender:
        await _storage.write(key: StorageKeys.userGender, value: data);
        break;
      case LocalEnumKey.birthDate:
        await _storage.write(key: StorageKeys.userBirthDate, value: data);
        break;
      case LocalEnumKey.languageCode:
        _languageCode = data;
        await _storage.write(key: StorageKeys.languageCode, value: data);
        break;
      case LocalEnumKey.role:
        _role = data;
        await _storage.write(key: StorageKeys.userRole, value: data);
        break;
    }
  }

  Future<String?> getLocalData({required LocalEnumKey keyType}) async {
    switch (keyType) {
      case LocalEnumKey.accessToken:
        _accessToken ??= await _storage.read(key: StorageKeys.accessToken);
        return _accessToken;

      case LocalEnumKey.refreshToken:
        _refreshToken ??= await _storage.read(key: StorageKeys.refreshToken);
        return _refreshToken;

      case LocalEnumKey.userId:
        _userId ??= await _storage.read(key: StorageKeys.userId);
        return _userId;
      case LocalEnumKey.fullName:
        return await _storage.read(key: StorageKeys.userName);
      case LocalEnumKey.phone:
        return await _storage.read(key: StorageKeys.userPhone);
      case LocalEnumKey.gender:
        return await _storage.read(key: StorageKeys.userGender);
      case LocalEnumKey.birthDate:
        return await _storage.read(key: StorageKeys.userBirthDate);
      case LocalEnumKey.languageCode:
        _languageCode ??= await _storage.read(key: StorageKeys.languageCode);
        return _languageCode;
      case LocalEnumKey.role:
        _role ??= await _storage.read(key: StorageKeys.userRole);
        return _role;
    }
  }

  Future<void> clearAuthSession() async {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
    _role = null;

    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
    await _storage.delete(key: StorageKeys.userId);
    await _storage.delete(key: StorageKeys.userName);
    await _storage.delete(key: StorageKeys.userPhone);
    await _storage.delete(key: StorageKeys.userGender);
    await _storage.delete(key: StorageKeys.userBirthDate);
    await _storage.delete(key: StorageKeys.userRole);
  }

  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
    _languageCode = null;
    _role = null;

    await _storage.deleteAll();
  }
}
