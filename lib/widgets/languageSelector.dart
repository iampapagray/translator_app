import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/controllers/languageController.dart';
import 'package:translator/models/language.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final LanguageController langCtrl = Get.find<LanguageController>();
    // langCtrl.initLanguages();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      height: 60,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              DropDownState(
                DropDown(
                  bottomSheetTitle: const Text(
                    'Translate From',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  data: langCtrl.languages,
                  selectedItems: (List<dynamic> selectedList) {
                    var item = selectedList[0];
                    if (item is SelectedListItem) {
                      langCtrl.updateFromLang(Lang(item.name, item.value!));
                    }
                  },
                  enableMultipleSelection: false,
                ),
              ).showModal(context);
            },
            child: LanguageDropdown(language: langCtrl.fromLang),
          ),
          const Center(
            child: Icon(
              Icons.swap_horiz,
              size: 32,
              color: Colors.greenAccent,
            ),
          ),
          InkWell(
            onTap: () {
              DropDownState(
                DropDown(
                  bottomSheetTitle: const Text(
                    'Translate To',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  data: langCtrl.languages,
                  selectedItems: (List<dynamic> selectedList) {
                    var item = selectedList[0];
                    if (item is SelectedListItem) {
                      langCtrl.updateToLang(Lang(item.name, item.value!));
                    }
                  },
                  enableMultipleSelection: false,
                ),
              ).showModal(context);
            },
            child: LanguageDropdown(language: langCtrl.toLang),
          ),
        ],
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key, required this.language});

  final Rx<Lang> language;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFf4f6fa),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: width * 0.27,
                  minWidth: width * 0.15,
                ),
                child: Text(
                  language.value.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.expand_more,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
