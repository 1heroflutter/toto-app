import 'package:flutter/material.dart';

import '../../core/config/assets/app_images.dart';

class TaskIsEmpty extends StatelessWidget {
  const TaskIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.homeEmpty),
        Text(
          "What do you want to do today?",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          "Tap + to add your task",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
