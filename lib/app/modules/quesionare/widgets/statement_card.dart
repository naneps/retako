import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';

class StatementCard extends StatelessWidget {
  StatementCard({
    super.key,
    this.index,
    required this.question,
  });
  int? index;
  final QuestionModel question;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: const EdgeInsets.only(left: 10.0, right: 10),
      radius: 5,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Pernyataan ${index! + 1}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RoundedContainer(
            radius: 0,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Text(
              question.statement,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            children: List.generate(
              question.answers.length,
              (optionIndex) {
                return Row(
                  children: [
                    Radio<dynamic>(
                      value: question.answers.keys.toList()[optionIndex],
                      groupValue: question.selectedAnswer,
                      onChanged: (value) {
                        // setState(() {});
                      },
                    ),
                    Text(
                      question.answers.values.toList()[optionIndex],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
