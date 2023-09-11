import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quesionare_controller.dart';

class QuestionaryView extends GetView<QuestionaryController> {
  const QuestionaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuesionareView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuesionareView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
