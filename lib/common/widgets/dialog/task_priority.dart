import 'package:flutter/material.dart';

class TaskPriorityDialog extends StatefulWidget {
  const TaskPriorityDialog({super.key});

  @override
  State<TaskPriorityDialog> createState() => _TaskPriorityDialogState();
}

class _TaskPriorityDialogState extends State<TaskPriorityDialog> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(width: 2, color: theme.colorScheme.onSecondary),
      ),
      backgroundColor: theme.colorScheme.background,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                "Task Priority",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(10, (index) {
                    final value = index + 1;
                    final isSelected = selected == value;

                    return GestureDetector(
                      onTap: () => setState(() => selected = value),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? theme.primaryColor
                              : theme.colorScheme.secondaryContainer,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flag,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onBackground,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "$value",
                              style: TextStyle(
                                color: isSelected
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        WidgetStatePropertyAll(theme.primaryColor),
                      ),
                      onPressed: () => Navigator.pop(context, selected),
                      child: Text(
                        "Save",
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
