import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/home/bindings/home_binding.dart';
import 'package:getx_pattern_starter/app/modules/home/views/home_view.dart';
import 'package:sp_util/sp_util.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  String smoking = '';
  String smokingSince = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('RETAKO'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            RoundedContainer(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Apakah Anda Merokok?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Ya",
                        groupValue: smoking,
                        onChanged: (value) {
                          setState(() {
                            smoking = value!;
                          });
                        },
                      ),
                      const Text("Ya"),
                      Radio<String>(
                        value: "Tidak",
                        groupValue: smoking,
                        onChanged: (value) {
                          setState(() {
                            smoking = value!;
                          });
                        },
                      ),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
            RoundedContainer(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sejak kapan Anda mulai merokok?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<String>(
                        value: "SD",
                        groupValue: smokingSince,
                        onChanged: (value) {
                          setState(() {
                            smokingSince = value!;
                          });
                        },
                      ),
                      const Text("SD"),
                      Radio<String>(
                        value: "SMP",
                        groupValue: smokingSince,
                        onChanged: (value) {
                          setState(() {
                            smokingSince = value!;
                          });
                        },
                      ),
                      const Text("SMP"),
                      Radio<String>(
                        value: "SMA / SMK",
                        groupValue: smokingSince,
                        onChanged: (value) {
                          setState(() {
                            smokingSince = value!;
                          });
                        },
                      ),
                      const Text("SMA / SMK"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Kuliah",
                        groupValue: smokingSince,
                        onChanged: (value) {
                          setState(() {
                            smokingSince = value!;
                          });
                        },
                      ),
                      const Text("Kuliah"),
                      Radio<String>(
                        value: "Lainnya",
                        groupValue: smokingSince,
                        onChanged: (value) {
                          setState(() {
                            smokingSince = value!;
                          });
                        },
                      ),
                      const Text("Lainnya"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            XButton(
              text: "Simpan",
              onPressed: () {
                saveForm();
              },
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> questions = [
    {
      "question_id": 1,
      "question_text": "Apakah Anda merokok?",
      "question_type": "yes_no",
      "options": ["Ya", "Tidak"]
    },
    {
      "question_id": 2,
      "question_text": "Sejak kapan Anda mulai merokok?",
      "question_type": "multiple_choice",
      "options": ["SD", "SMP", "SMA / SMK", "Kuliah", "Lainnya"]
    }
  ];

  void saveForm() {
    if (smoking.isEmpty || smokingSince.isEmpty) {
      Utils.snackMessage(
          title: "Perhatiam",
          messages: "Umur dan Jenis Kelamin tidak boleh kosong",
          type: "warning");
    } else {
      SpUtil.putString("smoking", smoking);
      SpUtil.putString("smokingSince", smokingSince);
      Get.to(
        () => HomeView(),
        transition: Transition.rightToLeft,
        binding: HomeBinding(),
      );
    }
  }
}
