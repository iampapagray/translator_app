import 'dart:async';
import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/models/language.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:translator/models/saved.dart';
import 'package:translator/services/database.dart';
import 'package:translator/services/network_handler.dart';

class LanguageController extends GetxController {
  var fromLang = Lang('English (US)', 'en').obs;
  var toLang = Lang('Chinese', 'cn').obs;
  List<SelectedListItem> languages = <SelectedListItem>[].obs;
  var inputCtrl = TextEditingController().obs;
  var isLoading = false.obs;
  var isSaving = false.obs;
  var isSaved = false.obs;
  var translatedText = ''.obs;
  var isFetching = false.obs;
  var savedTranslations = [].obs;

  void initLanguages() async {
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
    isLoading.value = true;
    translatedText.value = '';
    isSaved.value = false;
    var response = await NetworkHandler().post('/translate',
        fromLang.value.code, toLang.value.code, inputCtrl.value.text);
    var responseData = json.decode(response);
    translatedText.value = responseData['data']['translatedText'];

    isLoading.value = false;
  }

  void saveTranslation() async {
    isSaving.value = true;
    var saved = Saved(
      initial: inputCtrl.value.text,
      translated: translatedText.value,
      fromLang: fromLang.value.name,
      toLang: toLang.value.name,
    );

    Database db = Database();
    List<String> savedItems = [];

    Timer(const Duration(seconds: 1), () async {
      List<String>? saves = db.prefs.getStringList('saves');

      if (saves != null) {
        savedItems = saves;
      }
      saved.id = savedItems.length + 1;
      var savedString = saved.toString();
      savedItems.add(savedString);

      await db.prefs.setStringList('saves', savedItems);
      isSaved.value = true;
      isSaving.value = false;
    });
  }

  void copyToClipboard(String text) {
    FlutterClipboard.copy(text).then(
        (_) => NetworkHandler().showSnack('Translation copied', 'Success'));
  }

  void fetchSaved() {
    isFetching.value = true;
    Database db = Database();

    Timer(const Duration(seconds: 1), () {
      List<String>? saves = db.prefs.getStringList('saves');

      if (saves != null) {
        savedTranslations.clear();

        for (var i = 0; i < saves.length; i++) {
          var saved = Saved.fromString(saves[i]);
          savedTranslations.add(saved);
        }
      }
      savedTranslations.sort((a, b) => b.id.compareTo(a.id));
      isFetching.value = false;
    });
  }
}
