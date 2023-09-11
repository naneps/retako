import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/controllers/quesionnare_proactive_csc_controller.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/controllers/quesionnare_self_effeciency_controller.dart';
import 'package:getx_pattern_starter/app/services/quesionare_stream_service.dart';

import '../controllers/quesionare_controller.dart';

class QuestionaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionaryController>(
      () => QuestionaryController(),
    );
    Get.lazyPut<QuestionnaireSelfEfficiencyController>(
        () => QuestionnaireSelfEfficiencyController());

    Get.lazyPut<QuestionnaireStreamService>(() => QuestionnaireStreamService());
    Get.lazyPut<QuestionaryProactiveCSCController>(
        () => QuestionaryProactiveCSCController());
  }
}
