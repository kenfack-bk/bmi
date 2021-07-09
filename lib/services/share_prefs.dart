import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  static SharedPreferences? _instance;

  static final String nameKey = 'name';
  static final String ageKey = 'age';
  static final String sexeKey = 'sexe';
  static final String photoKey = 'photo';

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static String getName() {
    String? value = _instance!.getString(nameKey);
    return value == null ? '' : value;
  }

  static String getSexe() {
    String? value = _instance!.getString(sexeKey);
    return value == null ? 'man' : value;
  }

  static String getPhoto() {
    String? value = _instance!.getString(photoKey);
    return value == null ? '' : value;
  }

  static int getAge() {
    int? value = _instance!.getInt(ageKey);
    return value == null ? 21 : value;
  }

  static void setString(String key, String value) {
    _instance!.setString(key, value);
  }

  static void setInt(String key, int value) {
    _instance!.setInt(key, value);
  }
}
