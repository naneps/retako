import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
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
      String result = analyzeSelfEfficacySmoking(selfEfficacyScore.value);
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
  String analyzeSelfEfficacySmoking(int selfEfficacyScore) {
    if (selfEfficacyScore < 20) {
      return "Low";
    } else if (selfEfficacyScore >= 20 && selfEfficacyScore <= 30) {
      return "Moderate";
    } else {
      return "High";
    }
  }

  Future<void> saveToFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final respondent = RespondentModel()
      ..selfEfficacyScore = selfEfficacyScore.value
      ..questionSelfEfficiencyAnswered = questions
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
            .update(respondent.toJson());
        print("Respondent data updated successfully.");
        // return true; // Successfully updated data.
      }
    } catch (e) {
      print("Error: $e");
      // return false; // Handle the error or take appropriate action here.
    }
  }
}
