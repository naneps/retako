import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/views/result_effeciency_view.dart';
import 'package:getx_pattern_starter/app/services/quesionare_stream_service.dart';
import 'package:sp_util/sp_util.dart';

class QuestionnaireSelfEfficiencyController extends GetxController {
  final QuestionnaireStreamService _questionnaireStreamService =
      Get.find<QuestionnaireStreamService>();
  RxInt totalQuestions = 0.obs;
  RxInt questionAnswered = 0.obs;
  RxInt selfEfficacyScore = 0.obs;

  Stream<List<QuestionSelfEfficiencyModel>> getQuestionsSelfEfficiency() {
    return _questionnaireStreamService.getQuestionsSelfEfficiency();
  }

  RxList<QuestionSelfEfficiencyModel> questions =
      <QuestionSelfEfficiencyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getQuestionsSelfEfficiency().listen((event) {
      totalQuestions.value = event.length;
      questions.value = event;
    });
  }

  // Calculate the self-efficacy score
  void calculateScore() {
    int score = 0;
    for (var element in questions) {
      score += element.selectedWeight.value;
    }
    selfEfficacyScore.value = score;
  }

  // Save the questionnaire responses
  void save() {
    if (questionAnswered.value == totalQuestions.value) {
      calculateScore();
      String result = analyzeSelfEfficacySmoking(selfEfficacyScore.value)!;
      print("Self-efficacy score: ${selfEfficacyScore.value}");
      print("Self-efficacy analysis: $result");
      saveToFirestore();
    } else {
      Utils.snackMessage(
          title: "Attention",
          messages: "Answers are not complete",
          type: "warning");
    }
  }

  // Analyze self-efficacy for smoking cessation
  String? analyzeSelfEfficacySmoking(int selfEfficacyScore) {
    if (selfEfficacyScore <= 12 && selfEfficacyScore <= 27) {
      return "Rendah";
    } else if (selfEfficacyScore >= 28 && selfEfficacyScore <= 43) {
      return "Cukup";
    } else if (selfEfficacyScore >= 44 && selfEfficacyScore <= 60) {
      return "Tinggi";
    }
    return null;
  }

  Future<void> saveToFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final respondentId = SpUtil.getString("respondentId");
    final respondent = RespondentModel(
      age: SpUtil.getString("age"),
      gender: SpUtil.getString("gender"),
      smoking: SpUtil.getString("smoking"),
      smokingSince: SpUtil.getString("smokingSince"),
    );
    final questionnaireData = {
      "score": selfEfficacyScore.value,
      "answeredAt": DateTime.now().toIso8601String(),
      "questions": questions.map((e) => e.toJson()).toList(),
    };
    if (respondentId != "" && respondentId!.isNotEmpty) {
      await firestore
          .collection("respondents")
          .doc(respondentId)
          .collection("questionnaire")
          .doc("selfEfficacy")
          .set(questionnaireData);
    } else {
      final docRef =
          await firestore.collection("respondents").add(respondent.toJson());
      await firestore
          .collection("respondents")
          .doc(docRef.id)
          .collection("questionnaire")
          .doc("selfEfficacy")
          .set(questionnaireData);
      SpUtil.putString("respondentId", docRef.id);
    }

    Get.to(
      () => const ResultEfficiencyView(),
      fullscreenDialog: true,
      arguments: {
        "selfEfficacyScore": selfEfficacyScore.value,
        "selfEfficacyAnalysis":
            analyzeSelfEfficacySmoking(selfEfficacyScore.value),
        "respondent": respondent,
      },
    );
  }
}
