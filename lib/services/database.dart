import 'package:shared_preferences/shared_preferences.dart';

class Database {
  late SharedPreferences prefs;

  Database() {
    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
