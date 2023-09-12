import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/widgets/statement_card.dart';

class CategoryProactiveCard extends GetView<CategoryProactiveController> {
  final QuestionnaireProactiveModel data;
  final Function(dynamic)? onAnswered;
  final Function(QuestionnaireProactiveModel) onAnsweredAll;
  const CategoryProactiveCard({
    Key? key,
    required this.data,
    this.onAnswered,
    required this.onAnsweredAll,
  }) : super(key: key);

  @override
  String? get tag => data.id;

  @override
  CategoryProactiveController get controller => Get.put(
        CategoryProactiveController(data: data),
        tag: tag!,
      );

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.transparent,
      borderColor: Colors.grey[300]!,
      borderWidth: 1,
      hasBorder: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            radius: 0,
            width: Get.width,
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Text(
              data.category,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Obx(() {
              return Row(
                children: [
                  Text(
                    "${data.questions.length} Pernyataan",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    " ${controller.questionAnswered} Terjawab",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }),
          ),
          buildQuestionList(),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildQuestionList() {
    return RoundedContainer(
      margin: const EdgeInsets.only(top: 10),
      width: Get.width,
      color: Colors.transparent,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.questions.length,
        itemBuilder: (context, index) {
          return StatementCard(
            question: data.questions[index],
            index: index,
            onAnswered: (question) {
              // controller.questionAnswered.value++;
              controller.answeredQuestions[index] = question;
              if (controller.isAnsweredAll.value) {
                data.isAnsweredAll!.value = true;
                data.questions = controller.answeredQuestions;
                printInfo(info: "data: ${data.toJson()}");
                onAnsweredAll(data);
              }
            },
          );
        },
      ),
    );
  }
}

class CategoryProactiveController extends GetxController {
  final QuestionnaireProactiveModel data;

  CategoryProactiveController({
    required this.data,
  });

  RxInt questionAnswered = 0.obs;
  RxList<QuestionModel> answeredQuestions = <QuestionModel>[].obs;
  RxBool isAnsweredAll = false.obs;

  void checkAnsweredAll() {
    if (questionAnswered.value == data.questions.length) {
      isAnsweredAll.value = true;
      data.isAnsweredAll!.value = true;
      print("checkAnsweredAll called");
    } else {
      isAnsweredAll.value = false;
      data.isAnsweredAll!.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    answeredQuestions = data.questions.obs;
    for (var element in answeredQuestions) {
      element.isAnswered.listen((value) {
        if (value) {
          questionAnswered.value++;
        } else {
          questionAnswered.value--;
        }
      });
    }
    ever(questionAnswered, (_) {
      checkAnsweredAll();
    });
  }
}
