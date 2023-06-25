import 'package:flutter/material.dart';

import 'package:translator/controllers/languageController.dart';
import 'package:translator/models/saved.dart';

class SavedItemBox extends StatelessWidget {
  final Saved savedItem;
  final LanguageController langCtrl;

  const SavedItemBox({
    Key? key,
    required this.savedItem,
    required this.langCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        height: height * 0.25,
        width: width,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                savedItem.initial,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              LanguageBox(language: savedItem.fromLang),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                width: width,
                height: 1,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  langCtrl.copyToClipboard(savedItem.translated);
                },
                child: Text(
                  savedItem.translated,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              LanguageBox(language: savedItem.toLang),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageBox extends StatelessWidget {
  const LanguageBox({
    Key? key,
    required this.language,
  }) : super(key: key);

  final String language;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        // width: 80,
        child: Center(
          child: Text(
            language,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
