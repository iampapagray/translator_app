import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/models/language.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:translator/services/database.dart';
import 'package:translator/services/network_handler.dart';

class LanguageController extends GetxController {
  var fromLang = Lang('English (US)', 'en').obs;
  var toLang = Lang('Chinese', 'cn').obs;
  List<SelectedListItem> languages = <SelectedListItem>[].obs;

  void initLanguages() async {
    print('Getting Languages');
    var response = await NetworkHandler().get('/getLanguages');
    var responseData = json.decode(response);
    var langList = langsFromJson(responseData['data']['languages']);
    convertToDropdownList(langList);
    setDefaultLangs();
  }

  List<Lang> langsFromJson(List<dynamic> jsonList) {
    return jsonList.map((jsonObject) => Lang.fromJson(jsonObject)).toList();
  }

  void convertToDropdownList(List<Lang> langList) {
    languages = langList
        .map((lang) => SelectedListItem(
            name: lang.name, value: lang.code, isSelected: false))
        .toList();
  }

  void setDefaultLangs() async {
    print('Setting defaults');
    Database db = Database();

    Timer(const Duration(seconds: 1), () {
      String? defaultFrom = db.prefs.getString('fromLang');
      String? defaultTo = db.prefs.getString('toLang');

      if (defaultFrom == null) {
        db.prefs.setString('fromLang', Lang('English', 'en').toString());
        db.prefs.setString('toLang', Lang('French', 'fr').toString());
      } else {
        fromLang.value = Lang.fromString(defaultFrom);
        toLang.value = Lang.fromString(defaultTo!);
      }
    });
  }

  void updateFromLang(Lang selected) {
    fromLang.value = selected;

    Database db = Database();
    Timer(const Duration(seconds: 1), () {
      db.prefs.setString('fromLang', fromLang.value.toString());
    });
  }

  void updateToLang(Lang selected) {
    toLang.value = selected;

    Database db = Database();
    Timer(const Duration(seconds: 1), () {
      db.prefs.setString('toLang', toLang.value.toString());
    });
  }

  void translateText() async {
    var response = await NetworkHandler().post(
        '/translate', fromLang.value.code, toLang.value.code, 'I am a boy');
    var responseData = json.decode(response);
    print(responseData);
  }
}
