import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/controllers/languageController.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final LanguageController langCtrl = Get.find<LanguageController>();
    langCtrl.initLanguages();

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
                  data: [],
                  selectedItems: (List<dynamic> selectedList) {
                    List<String> list = [];
                    for (var item in selectedList) {
                      if (item is SelectedListItem) {
                        list.add(item.name);
                      }
                    }
                    print(list[0]);
                  },
                  enableMultipleSelection: false,
                ),
              ).showModal(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: const Text('English (US)'),
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
                  data: [],
                  selectedItems: (List<dynamic> selectedList) {
                    List<String> list = [];
                    for (var item in selectedList) {
                      if (item is SelectedListItem) {
                        list.add(item.name);
                      }
                    }
                    print(list[0]);
                  },
                  enableMultipleSelection: false,
                ),
              ).showModal(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text('Japanese'),
            ),
          ),
        ],
      ),
    );
  }
}
