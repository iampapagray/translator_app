import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/controllers/languageController.dart';
import 'package:translator/widgets/inputBox.dart';
import 'package:translator/widgets/languageSelector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final LanguageController langCtrl = Get.put(LanguageController());

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              LanguageSelector(),
              SizedBox(height: 16),
              InputBox(),
            ],
          ),
        ),
      ),
    );
  }
}
