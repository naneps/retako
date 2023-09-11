import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';

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
          .map((doc) => QuestionnaireProactiveModel.fromJson(doc.data()))
          .toList();
    });
  }
}
