import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_Icon_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/controllers/quesionnare_proactive_csc_controller.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/widgets/category_proactive_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QuestionaryProactiveCSCView
    extends GetView<QuestionaryProactiveCSCController> {
  const QuestionaryProactiveCSCView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        RoundedContainer(
          margin: const EdgeInsets.all(10.0),
          width: Get.width,
          height: 50,
          radiusType: RadiusType.circle,
          color: Colors.transparent,
          hasShadow: true,
          child: ElevatedButton(
            onPressed: () {
              // controller.submit();
              controller.submit();
            },
            child: const Text("Submit"),
          ),
        ),
      ],
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
                const Spacer(),
                XIconButton(
                  icon: MdiIcons.information,
                  size: 25,
                  onTap: () {
                    // dialog keterangan skor
                    Get.defaultDialog(
                      title: "Keterangan Skor",
                      content: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 10),
                              const Text("Skor 0 - 71 = Rendah"),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 10),
                              const Text("Skor 72 - 107 = Cukup"),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 10),
                              const Text("Skor 108 -  144 = Tinggi"),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: controller.getQuestionsProactiveCSC(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Utils.loadingWidget(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return CategoryProactiveCard(
                          data: data,
                          onAnswered: (val) {},
                          onAnsweredAll: (questionnaireProactiveModel) {
                            controller.questions[index] =
                                questionnaireProactiveModel; // Update selectedAnswer here
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
