import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/question_s_e_model.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class QuestionCard extends StatefulWidget {
  final QuestionSelfEfficiencyModel question;
  final Function(dynamic)? onAnswerSelected;

  final int index;
  const QuestionCard({
    Key? key,
    required this.question,
    required this.index,
    this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radiusType: RadiusType.diagonal1,
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            color: ThemeApp.primaryColor,
            hasBorder: true,
            borderColor: Colors.brown,
            width: Get.width,
            radiusType: RadiusType.diagonal1,
            radius: 20,
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "Pertanyaan ${widget.index + 1}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          RoundedContainer(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            color: Colors.white30,
            child: Text(
              widget.question.questionText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: List.generate(
              widget.question.options.length,
              (optionIndex) {
                return Row(
                  children: [
                    Radio<int>(
                      value: widget.question.weights[optionIndex],
                      groupValue: widget.question.selectedWeight.value,
                      onChanged: (value) {
                        setState(() {
                          widget.question.selectedWeight.value = value!;
                          widget.question.selectedOption.value =
                              widget.question.options[optionIndex];
                          widget.question.isAnswered!.value = true;
                          widget.onAnswerSelected!(widget.question);
                        });
                      },
                    ),
                    Text(
                      widget.question.options[optionIndex],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
