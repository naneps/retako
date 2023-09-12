import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuestionnaireProactiveModel {
  final String category;
  List<QuestionModel> questions;
  RxBool? isAnsweredAll = false.obs;
  final String id;
  QuestionnaireProactiveModel({
    required this.category,
    required this.questions,
    required this.id,
    this.isAnsweredAll,
  });

  factory QuestionnaireProactiveModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as String;
    final questionsList = json['questions'] as List<dynamic>;
    final questions = questionsList
        .map((question) => QuestionModel.fromJson(question))
        .toList();
    final id = json['id'] as String;
    return QuestionnaireProactiveModel(
      category: category,
      questions: questions,
      id: id,
    );
  }

  // from firestore
  QuestionnaireProactiveModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        category = doc['category'],
        questions = List<QuestionModel>.from(
          doc['questions'].map(
            (question) => QuestionModel.fromJson(question),
          ),
        );
  toJson() {
    return {
      "category": category,
      "questions": questions.map((e) => e.toJson()).toList(),
      "isAnsweredAll":
          isAnsweredAll!.value, // Use .value to get the boolean value
      "answeredAt": DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class QuestionModel {
  final String statement;
  final Map<String, String> answers;
  String? selectedAnswer;
  int? selectedWeight;
  RxBool isAnswered = false.obs;

  QuestionModel({
    required this.statement,
    required this.answers,
    this.selectedAnswer,
    this.selectedWeight,
    required this.isAnswered,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final statement = json['statement'] as String;
    final answersMap = json['answers'] as Map<String, dynamic>;
    final answers =
        answersMap.map((key, value) => MapEntry(key, value as String));

    return QuestionModel(
      statement: statement,
      answers: answers,
      isAnswered: false.obs,
    );
  }
  // to json
  toJson() {
    return {
      "statement": statement,
      "answers": answers,
      "selectedAnswer": selectedAnswer,
      "isAnswered": isAnswered.value,
      "selectedWeight": selectedWeight,
      "answeredAt": DateTime.now().millisecondsSinceEpoch,
    };
  }
}
