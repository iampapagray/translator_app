import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/controllers/languageController.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
                    maxLines: 7,
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
                  print("clear input");
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
              print('Doing Translate');
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
              child: const Center(
                child: Text(
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
      ]),
    );
  }
}
