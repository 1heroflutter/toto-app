import 'package:flutter/material.dart';
import 'package:reactive_button/reactive_button.dart';

class BasicReactBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  final VoidCallback onSuccess;
  const BasicReactBtn({super.key, required this.label, required this.onPress, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ReactiveButton(
        onPressed: () async {
          onPress();
        },
        onSuccess: () async {
          onSuccess();
        },
        onFailure: (String error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        },
        title: label,
      ),
    );
  }
}
