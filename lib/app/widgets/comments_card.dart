import 'package:flutter/material.dart';
import 'package:scelloo_task/app/constants/app_colors.dart';
import 'package:scelloo_task/app/widgets/custom_texts.dart';

class CommentsCard extends StatelessWidget {
  const CommentsCard({
    super.key,
    required this.comment,
    required this.user,
  });
  final String comment;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 26, 26),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mediumText(
            comment,
            fontSize: 18,
            textColor: AppColor.whiteTextColor,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColor.whiteTextColor,
                child: Icon(Icons.person, color: Color.fromARGB(255, 26, 26, 26),),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  regularText(
                    'commented by',
                    textColor: AppColor.whiteTextColor,
                    fontSize: 12,
                  ),
                  mediumText(
                    user,
                    fontSize: 14,
                    textColor: AppColor.whiteTextColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
