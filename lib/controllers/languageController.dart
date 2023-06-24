import 'dart:convert';

import 'package:get/get.dart';
import 'package:translator/models/language.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:translator/services/network_handler.dart';

class LanguageController extends GetxController {
  var fromLang = Lang('English (US)', 'en').obs;
  var toLang = Lang('English (US)', 'en').obs;

  late RxList<SelectedListItem> languages; // = [].obs;

  void initLanguages() async {
    print('Getting Languages');
    var response = await NetworkHandler().get('/getLanguages');
    var responseData = json.decode(response);
    var langList = langsFromJson(responseData['data']['languages']);

    print(langList[0].name);
  }

  List<Lang> langsFromJson(List<dynamic> jsonList) {
    return jsonList.map((jsonObject) => Lang.fromJson(jsonObject)).toList();
  }
}
