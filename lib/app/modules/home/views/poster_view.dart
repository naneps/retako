import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/xpicture.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class EducationPosterView extends GetView<EducationPosterController> {
  const EducationPosterView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10.0),
      width: Get.width,
      color: Colors.transparent,
      hasBorder: true,
      borderColor: ThemeApp.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Poster",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ThemeApp.lightColor,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemExtent: 150,
                  itemBuilder: (context, index) {
                    return RoundedContainer(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10.0),
                      gradient: LinearGradient(
                        colors: [
                          ThemeApp.backgroundColor,
                          ThemeApp.backgroundColor,
                          ThemeApp.primaryColor.withOpacity(0.5),
                          ThemeApp.primaryColor.withOpacity(0.5),
                          ThemeApp.backgroundColor,
                          ThemeApp.backgroundColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      hasBorder: true,
                      borderColor: ThemeApp.primaryColor,
                      child: const XPicture(
                        imageUrl: "",
                        assetImage: "assets/images/logo.png",
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class EducationPosterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
