import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/controllers/quesionnare_self_effeciency_controller.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/widgets/question_card.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class QuestionnaireSelfEfficiencyView
    extends GetView<QuestionnaireSelfEfficiencyController> {
  const QuestionnaireSelfEfficiencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        RoundedContainer(
          child: XButton(
            text: "Simpan",
            onPressed: () {
              controller.save();
            },
          ),
        )
      ],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                RoundedContainer(
                  margin: const EdgeInsets.all(10.0),
                  width: 50,
                  height: 50,
                  radiusType: RadiusType.circle,
                  color: Colors.transparent,
                  hasShadow: true,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  "RETAKO",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedContainer(
              padding: const EdgeInsets.all(12),
              color: Colors.transparent,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.totalQuestions} Pertanyaan ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ThemeApp.lightColor,
                      ),
                    ),
                    Text(
                      "${controller.questionAnswered} Terjawab",
                      style: TextStyle(
                        fontSize: 16,
                        color: ThemeApp.lightColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                );
              }),
            ),
            Expanded(
              child: RoundedContainer(
                width: Get.width,
                color: Colors.transparent,
                margin: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: controller.getQuestionsSelfEfficiency(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Utils.loadingWidget(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return QuestionCard(
                            index: index,
                            question: snapshot.data![index],
                            onAnswerSelected: (value) {
                              // Handle selected answer here
                              controller.questions[index] = value;
                              print(
                                  "question answered: ${controller.questions[index].toJson()}");
                              controller.questionAnswered.value = controller
                                  .questions
                                  .where((element) =>
                                      element.isAnswered!.value == true)
                                  .length;
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void uploadQuestionsToFirestore(List<Map<String, dynamic>> questions) async {
  final firestore = FirebaseFirestore.instance;

  for (final question in questions) {
    try {
      await firestore.collection('questions-proactive-csc').add(question);
      // print('Pertanyaan berhasil diupload: ${question.questionText}');
    } catch (e) {
      print('Error saat mengupload pertanyaan: $e');
    }
  }
}

final questions = [
  {
    "category": "SUPPORT SEEKING",
    "questions": [
      {
        "statement":
            "Teman- teman saya akan mendengarkan keluhan saya jika kesulitan berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Keluarga akan mendengarkan keluhan saya jika kesulitan untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya meminta bantuan orang lain untuk mengontrol upaya saya dalam berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Teman-teman memberi semangat kepada saya untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya akan melibatkan orang terdekat yang mendukung upaya saya dalam berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Motivasi dari orang lain (guru, teman dan keluarga) membantu saya untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Informasi dari orang lain tentang bahaya rokok membantu saya untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya mencoba berdiskusi dan menjelaskan upaya saya dalam berhenti merokok untuk mendapat umpan balik dari orang lain ( guru, teman dan keluarga)",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement": "Saya mengganti merokok dengan permen ataupun cemilan",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya akan mempersiapkan diri untuk mengatasi kesulitan saat berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya membuat rencana berhenti merokok dan akan mengikutinya.",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      }
    ]
  },
  {
    "category": "REFLEKTIF KOPING",
    "questions": [
      {
        "statement":
            "Saya berpikir dapat menghemat pengeluaran jika saya berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement": "Berhenti merokok dapat memperbaiki keuangan saya",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement": "Tujuan saya berhenti merokok untuk kesehatan sendiri",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya berpikir dengan berhenti merokok akan meningkatkan kesehatan",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya membayangkan dengan melakukan olah raga dan kegiatan yang positif dapat membantu saya berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya mampu mengendalikan diri saya untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Tujuan saya berhenti merokok untuk kesehatan keluarga dan orang disekitar saya",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      }
    ]
  },
  {
    "category": "STRATEGI COPING",
    "questions": [
      {
        "statement":
            "Saya memiliki rencana untuk mengatasi tantangan dalam upaya berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya akan selalu meningkatkan upaya berhenti merokok dengan cara mengevaluasi tindakan yang sudah dilakukan",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya merencanakan strategi untuk berhenti merokok, saya berharap akan menjadi hasil yang terbaik",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya akan berhenti merokok secara bertahap dengan mengurangi jumlah rokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya melakukan olah raga atau kegiatan positif lainnya untuk tidak merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement": "Saya melindungi kesehatan keluarga dengan tidak merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      }
    ]
  },
  {
    "category": "PROACTIVE COPING",
    "questions": [
      {
        "statement":
            "Saya membayangkan akan sulit berhenti merokok namun saya akan tetap menjalaninya",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya menganggap berhenti merokok sebagai tantangan yang harus dihadapi",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya akan menguatkan niat saya untuk berhenti merokok, jika saya mengalami hambatan",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya akan menyakinkan orang lain bahwa saya mampu berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Kesulitan menghadapi tantangan merokok akan saya anggap sebagai pengalaman positif",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Masalah kesehatan membuat saya berinisiatif untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      }
    ]
  },
  {
    "category": "AVOIDANCE",
    "questions": [
      {
        "statement": "Saya lebih memilih tidur dari pada merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya memilih tidak berkumpul dengan teman agar terhindar dari keinginan merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement": "Saya lebih baik menghindari orang yang mengajak merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      }
    ]
  },
  {
    "category": "PREVENTIF",
    "questions": [
      {
        "statement":
            "Saya berusaha menunjukkan kepada orang lain saya mampu menghindari merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Saya selalu berusaha menemukan cara untuk berhenti merokok",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      },
      {
        "statement":
            "Meskipun berhenti merokok itu sulit, saya akan berusaha mencapainya",
        "answers": {
          "1": "Tidak benar sama sekali",
          "2": "Kadang-kadang",
          "3": "Agak benar",
          "4": "Sangat benar",
          "5": "Sangat benar sekali"
        }
      }
    ]
  }
];
