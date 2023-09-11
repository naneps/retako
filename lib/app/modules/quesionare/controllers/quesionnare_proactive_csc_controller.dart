import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/services/quesionare_stream_service.dart';

class QuestionaryProactiveCSCController extends GetxController {
  RxInt totalQuestions = 0.obs;
  RxInt totalCategories = 0.obs;

  RxInt questionAnswered = 0.obs;

  final QuestionnaireStreamService _questionnaireStreamService =
      Get.find<QuestionnaireStreamService>();
  Stream<List<QuestionnaireProactiveModel>> getQuestionsProactiveCSC() {
    return _questionnaireStreamService.getQuestionsProactiveCSC();
  }
}
