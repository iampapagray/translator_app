import 'package:shared_preferences/shared_preferences.dart';

class Database {
  late SharedPreferences prefs;

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }
}
