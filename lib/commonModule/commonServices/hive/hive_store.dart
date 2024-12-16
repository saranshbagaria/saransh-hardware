import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';

import '../../../main.dart';

/// A singleton class for managing encrypted storage using Hive.
class HiveStore {
  // Singleton instance
  static final HiveStore _instance = HiveStore._internal();

  // Late-initialized box for Hive storage
  static late Box _box;

  // Flag to check if running in a browser environment
  final bool _isBrowser = false;

  // Secure storage for the encryption key
  final _secureStorage = const FlutterSecureStorage();

  // Private constructor
  HiveStore._internal();

  // Factory constructor to return the singleton instance
  factory HiveStore() => _instance;

  // Getter for the singleton instance
  static HiveStore get instance => _instance;

  /// Initializes the Hive box with encryption.
  Future<void> initBox() async {
    Uint8List encryptionKey = await _getOrGenerateEncryptionKey();
    _box = await _openEncryptedBox(encryptionKey);
  }

  /// Retrieves or generates a new encryption key.
  Future<Uint8List> _getOrGenerateEncryptionKey() async {
    Uint8List? key = await _retrieveEncryptionKey();
    if (key == null) {
      key = _generateEncryptionKey();
      await _storeEncryptionKey(key);
    }
    return key;
  }

  /// Generates a new encryption key.
  Uint8List _generateEncryptionKey() {
    String strongKey = _generateStrongKey(32);
    return Uint8List.fromList(sha256.convert(utf8.encode(strongKey)).bytes);
  }

  /// Stores the encryption key securely.
  Future<void> _storeEncryptionKey(Uint8List key) async {
    await _secureStorage.write(
        key: 'encryptionKey', value: base64UrlEncode(key));
  }

  /// Retrieves the encryption key from secure storage.
  Future<Uint8List?> _retrieveEncryptionKey() async {
    String? storedKey = await _secureStorage.read(key: 'encryptionKey');
    return storedKey != null ? base64Url.decode(storedKey) : null;
  }

  /// Opens an encrypted Hive box.
  Future<Box> _openEncryptedBox(Uint8List encryptionKey) async {
    if (!_isBrowser) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    return await Hive.openBox('Store',
        encryptionCipher: HiveAesCipher(encryptionKey));
  }

  /// Stores an object in the Hive box.
  Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
    logger.debug("Stored in Hive: Key: $key, Value: $value");
  }

  /// Retrieves an object from the Hive box.
  dynamic get(String key) {
    dynamic value = _box.get(key);
    logger.debug("Retrieved from Hive: Key: $key, Value: $value");
    return value;
  }

  /// Stores a string in the Hive box.
  Future<void> setString(String key, String value) => put(key, value);

  /// Retrieves a string from the Hive box.
  String? getString(String key) => get(key) as String?;

  /// Stores a boolean in the Hive box.
  Future<void> setBool(String key, bool value) => put(key, value);

  /// Retrieves a boolean from the Hive box.
  bool? getBool(String key) => get(key) as bool?;

  /// Clears all data from the Hive box.
  Future<void> clear() => _box.clear();

  /// Removes a specific key-value pair from the Hive box.
  Future<void> remove(String key) => _box.delete(key);

  /// Generates a strong random key.
  static String _generateStrongKey(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)])
        .join();
  }
}

/// Constants for Hive keys.
class HiveKeys {
  static const String language = "LANGUAGE";
// Add more constants as needed
}
