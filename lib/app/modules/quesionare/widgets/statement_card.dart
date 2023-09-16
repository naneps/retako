import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';

class StatementCard extends StatefulWidget {
  StatementCard({
    super.key,
    this.index,
    required this.question,
    required this.onAnswered,
  });
  int? index;
  final QuestionModel question;
  final Function(dynamic) onAnswered;

  @override
  State<StatementCard> createState() => _StatementCardState();
}

class _StatementCardState extends State<StatementCard> {
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
              "Pernyataan ${widget.index! + 1}",
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
              widget.question.statement,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            children: List.generate(
              widget.question.answers.length,
              (optionIndex) {
                return Row(
                  children: [
                    Radio<int>(
                      value: int.parse(
                          widget.question.answers.keys.toList()[optionIndex]),
                      groupValue: widget.question.selectedWeight,
                      onChanged: (value) {
                        setState(() {
                          widget.question.selectedAnswer = widget
                              .question.answers.values
                              .toList()[optionIndex];

                          widget.question.isAnswered.value = true;
                          widget.question.selectedWeight = value!;
                          widget.onAnswered(widget.question);
                        });
                      },
                    ),
                    Text(
                      widget.question.answers.values.toList()[optionIndex],
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
