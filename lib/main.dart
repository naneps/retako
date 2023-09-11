import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/input/gender_picker.dart';
import 'package:getx_pattern_starter/app/modules/home/views/introduction_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:getx_pattern_starter/firebase_options.dart';
import 'package:sp_util/sp_util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RETAKO",
      onInit: () {
        SpUtil.clear();
      },
      // onclose app
      onDispose: () {
        print("DISPOSED");
        SpUtil.clear();
      },
      home: const IntroductionView(),
      initialBinding: BindingsBuilder(() {
        Get.put(GenderPickerController());
      }),
      getPages: AppPages.routes,
      theme: ThemeApp.defaultTheme,
    ),
  );
}
