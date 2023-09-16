import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';

class RespondentModel {
  String? age;
  String? gender;
  String? smoking;
  String? smokingSince;
  int? selfEfficacyScore;
  int? proactiveCSCScore;
  List<QuestionSelfEfficiencyModel> questionSelfEfficiencyAnswered =
      <QuestionSelfEfficiencyModel>[];
  List<QuestionnaireProactiveModel> questionProactiveCSCAnswered =
      <QuestionnaireProactiveModel>[];
  RespondentModel({
    this.age,
    this.gender,
    this.smoking,
    this.smokingSince,
    this.proactiveCSCScore,
    this.selfEfficacyScore,
    this.questionSelfEfficiencyAnswered = const <QuestionSelfEfficiencyModel>[],
    this.questionProactiveCSCAnswered = const <QuestionnaireProactiveModel>[],
  });
  // to json
  toJson() {
    return {
      "age": age,
      "gender": gender,
      "smoking": smoking,
      "smokingSince": smokingSince,
      "createdAt": DateTime.now().toIso8601String()
    };
  }

  // copy with
  RespondentModel copyWith({
    String? age,
    String? gender,
    String? smoking,
    String? smokingSince,
    int? selfEfficacyScore,
    int? proactiveCSCScore,
    List<QuestionSelfEfficiencyModel>? questionSelfEfficiencyAnswered,
    List<QuestionnaireProactiveModel>? questionProactiveCSCAnswered,
  }) {
    return RespondentModel(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      smoking: smoking ?? this.smoking,
      smokingSince: smokingSince ?? this.smokingSince,
      selfEfficacyScore: selfEfficacyScore ?? this.selfEfficacyScore,
      proactiveCSCScore: proactiveCSCScore ?? this.proactiveCSCScore,
      questionSelfEfficiencyAnswered:
          questionSelfEfficiencyAnswered ?? this.questionSelfEfficiencyAnswered,
      questionProactiveCSCAnswered:
          questionProactiveCSCAnswered ?? this.questionProactiveCSCAnswered,
    );
  }
}
