import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/views/result_proactive_view.dart';
import 'package:getx_pattern_starter/app/services/quesionare_stream_service.dart';
import 'package:sp_util/sp_util.dart';

class QuestionaryProactiveCSCController extends GetxController {
  RxInt totalQuestions = 0.obs;
  RxInt totalCategories = 0.obs;

  RxInt questionAnswered = 0.obs;
  RxInt proactiveCSCScore = 0.obs;

  final QuestionnaireStreamService _questionnaireStreamService =
      Get.find<QuestionnaireStreamService>();
  final RxList<QuestionnaireProactiveModel> questions =
      <QuestionnaireProactiveModel>[].obs;
  Stream<List<QuestionnaireProactiveModel>> getQuestionsProactiveCSC() {
    return _questionnaireStreamService.getQuestionsProactiveCSC();
  }

  void submit() {
    bool allQuestionsAnswered =
        questions.every((element) => element.isAnsweredAll!.value == true);
    print(allQuestionsAnswered);
    for (var element in questions) {
      print(element.isAnsweredAll!.value);
    }
    if (allQuestionsAnswered) {
      // All questions have been answered, proceed with your logic here
      calculateScore();
      saveToFirestore();
    } else {
      // Not all questions have been answered, handle this case accordingly
      Utils.snackMessage(
          title: "Perhatian",
          messages: "Anda belum menjawab semua permyataan",
          type: "warning");
    }
  }

  void calculateScore() {
    int score = 0;

    for (var question in questions) {
      score += question.questions.fold(0, (prevScore, element) {
        if (element.isAnswered.value) {
          proactiveCSCScore.value = prevScore + element.selectedWeight!;
          return prevScore + element.selectedWeight!;
        }
        proactiveCSCScore.value = prevScore;
        return prevScore;
      });
    }

    print('Score: $score');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getQuestionsProactiveCSC().listen((event) {
      questions.value = event;
      totalCategories.value = event.length;
      totalQuestions.value = event.fold(0, (prev, element) {
        return prev + element.questions.length;
      });
    });
  }

  Future<void> saveToFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final respondent = RespondentModel()
      ..proactiveCSCScore = proactiveCSCScore.value
      ..questionProactiveCSCAnswered = questions
      ..age = SpUtil.getString("age")
      ..gender = SpUtil.getString("gender")
      ..smoking = SpUtil.getString("smoking")
      ..smokingSince = SpUtil.getString("smokingSince");

    print("Respondent data: ${respondent.toJson()}");

    final respondentId = SpUtil.getString("respondentId");
    try {
      if (respondentId!.isEmpty) {
        final response =
            await firestore.collection("respondents").add(respondent.toJson());
        // ignore: unnecessary_null_comparison
        if (response != null) {
          SpUtil.putString("respondentId", response.id);
          // return true; // Successfully added new data.
        } else {
          print("Error: Failed to add respondent data to Firestore.");
          // return false; // Failed to add data.
        }
      } else {
        await firestore
            .collection("respondents")
            .doc(respondentId)
            .collection("questionnaires")
            .doc("proactive-csc")
            .set({
          "proactiveCSCScore": proactiveCSCScore.value,
          "questionProactiveCSCAnswered":
              questions.map((e) => e.toJson()).toList(),
        });
      }
      Get.to(
        () => const ResultProactiveCSC(),
        transition: Transition.rightToLeft,
        fullscreenDialog: true,
        arguments: {
          "score": proactiveCSCScore.value,
        },
      );
    } catch (e) {
      print("Error: $e");
      // return false; // Handle the error or take appropriate action here.
    }
  }
}
