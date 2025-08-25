import 'package:flutter/material.dart';

class BasicHeadline extends StatelessWidget {
  final String text;

  const BasicHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.secondaryContainer,
      ),
    );
  }
}
