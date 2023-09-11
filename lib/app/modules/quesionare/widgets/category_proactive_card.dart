import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/models/question_proactive_csc.dart';
import 'package:getx_pattern_starter/app/modules/quesionare/widgets/statement_card.dart';

class CategoryProactiveCard extends StatefulWidget {
  const CategoryProactiveCard({
    super.key,
    required this.data,
  });

  final QuestionnaireProactiveModel data;

  @override
  State<CategoryProactiveCard> createState() => _CategoryProactiveCardState();
}

class _CategoryProactiveCardState extends State<CategoryProactiveCard> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.transparent,
      borderColor: Colors.grey[300]!,
      borderWidth: 1,
      hasBorder: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            radius: 0,
            width: Get.width,
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Text(
              widget.data.category,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              children: [
                Text(
                  "${widget.data.questions.length} Pernyataan",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const Text(
                  "0 Terjawab",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.only(top: 10),
            width: Get.width,
            color: Colors.transparent,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.data.questions.length,
              itemBuilder: (context, index) {
                final statement = widget.data.questions[index].statement;
                return StatementCard(
                  question: widget.data.questions[index],
                  index: index,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
