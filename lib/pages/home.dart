import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/controllers/languageController.dart';
import 'package:translator/widgets/inputBox.dart';
import 'package:translator/widgets/languageSelector.dart';
import 'package:translator/widgets/outputBox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final LanguageController langCtrl = Get.find<LanguageController>();

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  const LanguageSelector(),
                  const SizedBox(height: 16),
                  const InputBox(),
                  const SizedBox(height: 16),
                  Obx(
                    () => langCtrl.translatedText.isNotEmpty
                        ? const OutputBox()
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
