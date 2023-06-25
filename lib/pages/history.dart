import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:translator/controllers/languageController.dart';
import 'package:translator/models/saved.dart';
import 'package:translator/widgets/savedItemBox.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController langCtrl = Get.find<LanguageController>();
    langCtrl.fetchSaved();

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () => langCtrl.isFetching.value
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 20,
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Obx(() {
                  if (langCtrl.savedTranslations.isEmpty) {
                    return const Center(
                      child: Text('No items saved.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: langCtrl.savedTranslations.length,
                    itemBuilder: (context, index) {
                      Saved item = langCtrl.savedTranslations[index];
                      return SavedItemBox(savedItem: item, langCtrl: langCtrl);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
