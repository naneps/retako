import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';

class RespondentModel {
  String? age;
  String? gender;
  String? smoking;
  String? smokingSince;
  int? selfEfficacyScore;
  List<QuestionSelfEfficiencyModel> questionSelfEfficiencyAnswered =
      <QuestionSelfEfficiencyModel>[];

  RespondentModel({
    this.age,
    this.gender,
    this.smoking,
    this.smokingSince,
    this.selfEfficacyScore,
    this.questionSelfEfficiencyAnswered = const <QuestionSelfEfficiencyModel>[],
  });
  // to json
  toJson() {
    return {
      "age": age,
      "gender": gender,
      "smoking": smoking,
      "smokingSince": smokingSince,
      "selfEfficacyScore": selfEfficacyScore,
      "questionSelfEfficiencyAnswered":
          questionSelfEfficiencyAnswered.map((e) => e.toJson()).toList(),
    };
  }
}
