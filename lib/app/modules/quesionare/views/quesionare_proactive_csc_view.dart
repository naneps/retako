import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/controllers/quesionnare_proactive_csc_controller.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/widgets/category_proactive_card.dart';

class QuestionaryProactiveCSCView
    extends GetView<QuestionaryProactiveCSCController> {
  const QuestionaryProactiveCSCView({super.key});

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
                        return CategoryProactiveCard(data: data);
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
