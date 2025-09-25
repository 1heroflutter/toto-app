import 'package:flutter/material.dart';

import '../../../service_locator.dart';
import '../textfield/dialog_textfield.dart';

class EditDialog extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController description;
  final VoidCallback onTap;
  const EditDialog({super.key, required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(18),
      ),
      backgroundColor: theme.colorScheme.secondaryContainer,
      child: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 8,
            left: 14,
            right: 14,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                    fontSize: 20
                ),
              ),
              BasicTextField(controller: title, label: "Title"),
              BasicTextField(
                controller: description,
                label: "Description",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          theme.primaryColor,
                        ),
                      ),
                      onPressed: onTap,
                      child: Text(
                        "Next",
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
