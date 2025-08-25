import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:mytodoapp/common/helper/app_navigator.dart';
import 'package:mytodoapp/common/widgets/appbar/basic_appbar.dart';
import 'package:mytodoapp/common/widgets/dialog/calender.dart';
import 'package:mytodoapp/common/widgets/dialog/choose_category.dart';
import 'package:mytodoapp/common/widgets/dialog/delete.dart';
import 'package:mytodoapp/common/widgets/dialog/edit_title.dart';
import 'package:mytodoapp/common/widgets/dialog/task_priority.dart';
import 'package:mytodoapp/presentation/edit/widgets/task_component.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = SizedBox(height: MediaQuery
        .of(context)
        .size
        .height * 0.02);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery
              .of(context)
              .size
              .height * 0.05,
        ),
        child: BasicAppBar(
          title: null,
          icon: Icons.cancel_outlined,
          onLeadingTap: () => AppNavigator.pop(context),
          suffer: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.repeat))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Title + Context
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "Context",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return EditDialog(title: TextEditingController(),
                          description: TextEditingController());
                    },);
                  },
                  icon: Icon(Icons.edit_outlined,
                      color: theme.colorScheme.onPrimary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Task Components
            TaskComponent(
              icon: const Icon(Icons.timer_outlined),
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return CalenderDialog(
                      controller: AdvancedCalendarController(DateTime.now()));
                },);
              },
              title: "Task Time:",
              content: Text(
                  "Time", style: TextStyle(color: theme.colorScheme.onPrimary)),
            ),
            spacing,
            TaskComponent(
              icon: const Icon(Icons.tag),
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return ChooseCategoryDialog();
                },);
              },
              title: "Task Category:",
              content: Row(
                children: [
                  Icon(Icons.school_outlined, size: 16,
                      color: theme.primaryColor),
                  const SizedBox(width: 6),
                  Text("Study",
                      style: TextStyle(color: theme.colorScheme.onPrimary)),
                ],
              ),
            ),
            spacing,
            TaskComponent(
              icon: const Icon(Icons.flag_outlined),
              title: "Task Priority:",
              content: Text("Default",
                  style: TextStyle(color: theme.colorScheme.onPrimary)),
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return TaskPriorityDialog();
                },);
              },
            ),
            spacing,
            TaskComponent(
              icon: const Icon(Icons.leaderboard_outlined),
              title: "Sub - Task:",
              content: Text("Add Sub - Task",
                  style: TextStyle(color: theme.colorScheme.onPrimary)),
            ),
            spacing,
            TaskComponent(
              title: 'Delete Task',
              icon: IconButton(onPressed: () {
                showDialog(context: context, builder: (context) {
                  return const DeleteDialog();
                },);
              }, icon: const Icon(Icons.delete_forever_outlined), color: Colors.red),

            ),
            const Spacer(),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                child: const Text(
                    "Edit Task", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
