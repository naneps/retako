import 'package:get/get.dart';

class QuestionnaireProactiveModel {
  final String category;
  final List<QuestionModel> questions;
  RxBool isAnsweredAll = false.obs;

  QuestionnaireProactiveModel({
    required this.category,
    required this.questions,
  });

  factory QuestionnaireProactiveModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as String;
    final questionsList = json['questions'] as List<dynamic>;
    final questions = questionsList
        .map((question) => QuestionModel.fromJson(question))
        .toList();

    return QuestionnaireProactiveModel(
      category: category,
      questions: questions,
    );
  }
  //
  toJson() {
    return {
      "category": category,
      "questions": questions.map((e) => e.toJson()).toList(),
      "isAnsweredAll": isAnsweredAll,
      "answeredAt": DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class QuestionModel {
  final String statement;
  final Map<String, String> answers;
  final String? selectedAnswer;
  RxBool? isAnswered = false.obs;

  QuestionModel({
    required this.statement,
    required this.answers,
    this.selectedAnswer,
    this.isAnswered,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final statement = json['statement'] as String;
    final answersMap = json['answers'] as Map<String, dynamic>;
    final answers =
        answersMap.map((key, value) => MapEntry(key, value as String));

    return QuestionModel(
      statement: statement,
      answers: answers,
    );
  }
  // to json
  toJson() {
    return {
      "statement": statement,
      "answers": answers,
      "selectedAnswer": selectedAnswer,
      "isAnswered": isAnswered,
    };
  }
}
