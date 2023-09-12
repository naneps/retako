import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:sp_util/sp_util.dart';
import 'package:uuid/uuid.dart';

class QuestionnaireStreamService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final questionSelfEfficiencyCollection = 'questions-self-efficiency';

  Stream<List<QuestionSelfEfficiencyModel>> getQuestionsSelfEfficiency() {
    return _firestore
        .collection(questionSelfEfficiencyCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => QuestionSelfEfficiencyModel.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<QuestionnaireProactiveModel>> getQuestionsProactiveCSC() {
    return _firestore
        .collection('questions-proactive-csc')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => QuestionnaireProactiveModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> saveForm(
    QuestionnaireType type, {
    List<QuestionSelfEfficiencyModel> selfEfficiencyQuestions = const [],
    List<QuestionnaireProactiveModel> proactiveCSCQuestions = const [],
    RxInt? selfEfficacyScore,
    RxInt? proactiveCSCScore,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final respondentId = SpUtil.getString("respondentId");
    final questionnaireId =
        const Uuid().v4(); // Generate a unique ID for the questionnaire

    final respondent = RespondentModel()
      ..age = SpUtil.getString("age")
      ..gender = SpUtil.getString("gender")
      ..smoking = SpUtil.getString("smoking")
      ..smokingSince = SpUtil.getString("smokingSince");

    print("Respondent data: ${respondent.toJson()}");

    try {
      if (respondentId!.isEmpty) {
        final response =
            await firestore.collection("respondents").add(respondent.toJson());

        if (response != null) {
          SpUtil.putString("respondentId", response.id);
        } else {
          print("Error: Failed to add respondent data to Firestore.");
          return;
        }
      }

      final questionnaireData = type == QuestionnaireType.ProactiveCSC
          ? {
              "proactiveCSCScore": proactiveCSCScore!.value,
              "questionProactiveCSCAnswered":
                  proactiveCSCQuestions.map((e) => e.toJson()).toList(),
            }
          : {
              "selfEfficacyScore": selfEfficacyScore!.value,
              "questionSelfEfficiencyAnswered":
                  selfEfficiencyQuestions.map((e) => e.toJson()).toList(),
            };

      // firestore
      //     .collection("respondents")
      //     .doc(respondentId)
      //     .collection("questionnaires")

      print("Successfully saved questionnaire data.");
    } catch (e) {
      print("Error: $e");
      // Handle the error or take appropriate action here.
    }
  }
}

enum QuestionnaireType { SelfEfficiency, ProactiveCSC }
