import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicBtn extends StatelessWidget {
  final VoidCallback onTap;
  final ThemeData theme;
  final String text;
  const BasicBtn({super.key, required this.onTap, required this.theme, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
