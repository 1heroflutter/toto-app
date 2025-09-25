import 'package:flutter/material.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onTap;
  final TaskEntity task;
  const DeleteDialog({super.key, required this.onTap, required this.task});

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
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Text('Are You sure you want to delete this task?',textAlign: TextAlign.center,style: TextStyle(color: theme.colorScheme.onPrimary,fontSize: 20),),
                    Text('Task title: ${task.title}',style: TextStyle(color: theme.colorScheme.onPrimary,fontSize: 20),),
                  ],
                )
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
                      onPressed:() {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          theme.primaryColor,
                        ),
                      ),
                      onPressed:onTap,
                      child: Text(
                        "Delete",
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
