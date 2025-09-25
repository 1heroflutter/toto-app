import 'package:flutter/material.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

class TaskComponent extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? content;
  final CategoryEntity? category;
  final VoidCallback? onTap;

  const TaskComponent({
    super.key,
    required this.title,
    required this.icon,
    this.content,
    this.onTap,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 16)),
          const Spacer(),
          if (content != null)
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: category!=null?Color(category!.color):theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: content,
              ),
            ),
        ],
      ),
    );
  }
}
