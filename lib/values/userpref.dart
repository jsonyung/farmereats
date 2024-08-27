import 'package:shared_preferences/shared_preferences.dart';

class UserPref{
  final String KEY_AUTH_TOKEN = "auth_token";
  final String KEY_NAME = "name";
  final String KEY_CLIENTCODE = "client_code";
  final String KEY_USERNAME = "username";
  final String KEY_PASSWORD = "password";
  final String KEY_USER_STATUS = "user_status";
  final String KEY_USER_TYPE = "user_type";
  final String KEY_APP_NAME = "app_name";
  final String KEY_DAPFLSPERCENT= "dApflsPercent";
  final String KEY_EXCHANGE= "exchange";
  final String KEY_REMEMBER_ME = "remember_me";
  final String KEY_REFRESH_TOKEN = "refresh_token";
  final String KEY_CONTRACTS = "contracts";
  final String KEY_SATURDAY = "saturday";
  final String DEFAULT_VALUE_PREFERENCE = "";
  final String KEY_APPNAME = "app_name";
  final String KEY_PACKAGENAME = "package_name";
  final String KEY_VERSION = "version";
  final String KEY_BUILDNUMBER = "build_number";

  UserPref._privateConstructor();

  static final UserPref instance = UserPref._privateConstructor();

  setString(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? DEFAULT_VALUE_PREFERENCE;
  }
  setInt(String key, int value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(key, value);
  }

  Future<int> getInt(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? 0;
  }

  setBoolean(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBoolean(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

}
