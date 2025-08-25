import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const BasicDialogTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      controller: controller,
      cursorColor: theme.primaryColor,

      decoration: InputDecoration(

        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.primaryColor),
        ) ,
        label: Text(label,style: TextStyle(color: theme.colorScheme.onPrimary),),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.onPrimary),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.onPrimary),
        ),
      ),
    );
  }
}
