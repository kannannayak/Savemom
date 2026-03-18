import 'package:get_storage/get_storage.dart';

class Cachehelper {
  static Future<void> savedata(String key, String value) async {
    final instancegetstorage = GetStorage();
    await instancegetstorage.write(key, value);
  }

  static Future<String?> getSaveddata(String key) async {
    final instancegetstorage = GetStorage();
    await instancegetstorage.initStorage;
    String? data = instancegetstorage.read(key);
    return data;
  }

  static Future<void> deletedata(String key) async {
    final instancegetstorage = GetStorage();
    await instancegetstorage.remove(key);
  }
}
