import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_discovery_app/core/errors/exceptions.dart';
import 'package:movie_discovery_app/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Cache user data locally
  Future<void> cacheUser(UserModel user);

  /// Get cached user data
  Future<UserModel?> getCachedUser();

  /// Clear cached user data
  Future<void> clearCache();

  /// Check if user data is cached
  Future<bool> hasCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  static const String _userKey = 'cached_user';

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await secureStorage.write(key: _userKey, value: userJson);
    } catch (e) {
      throw CacheException('Failed to cache user: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = await secureStorage.read(key: _userKey);
      if (userJson == null) return null;

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw CacheException('Failed to get cached user: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await secureStorage.delete(key: _userKey);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }

  @override
  Future<bool> hasCache() async {
    try {
      final userJson = await secureStorage.read(key: _userKey);
      return userJson != null;
    } catch (e) {
      return false;
    }
  }
}
