import 'package:flutter/material.dart';

import 'package:scelloo_task/app/widgets/custom_texts.dart';

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({super.key, required this.snackMessage});

  final String snackMessage;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        // top: 50.h,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // decoration: BoxDecoration(
      //     color: AppColor.whiteColor,
      //     ),
      content: mediumText(
        snackMessage,
        // fontSize: ,
      ),
    );
  }
}
