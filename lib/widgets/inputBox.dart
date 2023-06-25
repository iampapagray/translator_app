import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:translator/controllers/languageController.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    FocusNode focusNode = FocusNode();

    LanguageController langCtrl = Get.find<LanguageController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: height * 0.3,
      child: Column(children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  height: height,
                  child: TextFormField(
                    // autofocus: true,
                    controller: langCtrl.inputCtrl.value,
                    maxLines: 7,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Write here...',
                      contentPadding: EdgeInsets.all(14),
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  langCtrl.inputCtrl.value.clear();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: (height * 0.3) * 0.2,
          child: InkWell(
            onTap: () {
              focusNode.unfocus();
              langCtrl.translateText();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Obx(
                  () => langCtrl.isLoading.value
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 20,
                        )
                      : const Text(
                          'Translate ✌🏽',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
