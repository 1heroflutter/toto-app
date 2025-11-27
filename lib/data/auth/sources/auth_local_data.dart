import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mytodoapp/common/helper/mapper.dart';
import 'package:mytodoapp/data/auth/models/user.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';

abstract class AuthLocalData {
  Future<void> saveUser(UserModel user);

  Future<UserEntity?> loadUser();
  Future<bool> isFirstTime();
  Future<void> setFirstTimeFinished();
  Future<void> clear();
}

class AuthLocalDataImpl extends AuthLocalData {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String keyFirstTime = "is_first_time";

  @override
  Future<bool> isFirstTime() async {
    String? value = await storage.read(key: keyFirstTime);
    return value == null;
  }
  @override
  Future<void> setFirstTimeFinished() async {
    await storage.write(key: keyFirstTime, value: "false");
  }
  @override
  Future<void> clear() async {
    await storage.delete(key: "user");
  }

  @override
  Future<UserEntity?> loadUser() async {
    final jsonString = await storage.read(key: "user");
    if (jsonString == null) return null;
    return UserMapper.toEntity(UserModel.fromJson(jsonDecode(jsonString)));
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await storage.write(key: "user", value: jsonEncode(user.toJson()));
  }
}
