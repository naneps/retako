import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuestionSelfEfficiencyModel {
  final String? id;
  final String questionText;
  final List<String> options;
  final List<int> weights;
  final RxInt selectedWeight = 0.obs;
  final RxString selectedOption = ''.obs;
  RxBool? isAnswered = false.obs;

  QuestionSelfEfficiencyModel(
      {this.id,
      required this.questionText,
      required this.options,
      this.weights = const [1, 2, 3, 4, 5],
      this.isAnswered});

  Map<String, dynamic> toJson() {
    return {
      'text': questionText,
      'options': options,
      'weights': weights,
      'isAnswered': isAnswered!.value,
      'selectedWeight': selectedWeight.value,
      'selectedOption': selectedOption.value,
    };
  }

  // from fireststore

  QuestionSelfEfficiencyModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        questionText = doc['text'],
        options = List<String>.from(doc['options']),
        weights = List<int>.from(doc['weights']);
}
