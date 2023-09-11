import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/home/controllers/home_controller.dart';
import 'package:getx_pattern_starter/app/modules/home/views/education_view.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/bindings/quesionare_binding.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/views/quesionare_proactive_csc_view.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/views/quesionare_self_effeciency_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                RoundedContainer(
                  margin: const EdgeInsets.all(10.0),
                  width: 50,
                  height: 50,
                  radiusType: RadiusType.circle,
                  color: Colors.transparent,
                  hasShadow: true,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  "RETAKO",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                padding: const EdgeInsets.all(10.0),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return RoundedContainer(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(features[index]['image']),
                        Positioned(
                          bottom: 0,
                          child: InkWell(
                            onTap: () => features[index]['onTap'](),
                            child: RoundedContainer(
                              width: 100,
                              radius: 5,
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Masuk",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ThemeApp.darkColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> features = [
    {
      "title": "Edukasi Informasi",
      "route": "/education",
      "onTap": () => Get.to(() => const EducationView()),
      "image": "assets/images/education.png"
    },
    {
      "title": "Kuesioner Proaktif CSC",
      "route": "/question-proactive",
      "onTap": () => Get.to(
            () => const QuestionaryProactiveCSCView(),
            binding: QuestionaryBinding(),
            transition: Transition.rightToLeft,
          ),
      "image": "assets/images/pcsc_2.png"
    },
    {
      "title": "Kuesioner Self Efficiency",
      "route": "/quiz",
      "onTap": () => Get.to(
            () => const QuestionnaireSelfEfficiencyView(),
            binding: QuestionaryBinding(),
            transition: Transition.rightToLeft,
          ),
      "image": "assets/images/self_efi_2.png"
    },
  ];
}
