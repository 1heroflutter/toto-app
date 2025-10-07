import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:mytodoapp/common/helper/app_navigator.dart';
import 'package:mytodoapp/common/helper/formatPublishedDate.dart';
import 'package:mytodoapp/common/widgets/appbar/basic_appbar.dart';
import 'package:mytodoapp/common/widgets/dialog/calender.dart';
import 'package:mytodoapp/common/widgets/dialog/choose_category.dart';
import 'package:mytodoapp/common/widgets/dialog/delete.dart';
import 'package:mytodoapp/common/widgets/dialog/edit_title.dart';
import 'package:mytodoapp/common/widgets/dialog/task_priority.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/delete_task.dart';
import 'package:mytodoapp/domain/task/usecase/update_task.dart';
import 'package:mytodoapp/presentation/edit/widgets/expandable_text.dart';
import 'package:mytodoapp/presentation/edit/widgets/task_component.dart';
import 'package:mytodoapp/presentation/home/pages/home_page.dart';

import '../../../service_locator.dart';

class EditPage extends StatefulWidget {
  final TaskEntity task;

  const EditPage({super.key, required this.task});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController priorityController;
  late AdvancedCalendarController calendarController =
      AdvancedCalendarController(DateTime.now());
  CategoryEntity? category;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.task.title);
    description = TextEditingController(text: widget.task.content);
    priorityController = TextEditingController(
      text: widget.task.priority?.toString() ?? "",
    );
    category = widget.task.category;
    date = widget.task.date;
    calendarController = AdvancedCalendarController(date ?? DateTime.now());
    print("[Check date]:${widget.task.date}");
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    priorityController.dispose();
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final theme = Theme.of(context);
    final spacing = SizedBox(height: MediaQuery.of(context).size.height * 0.02);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          title: null,
          icon: Icons.cancel_outlined,
          onLeadingTap: () => AppNavigator.pop(context),
          suffer: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.repeat)),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Radio(
                value: false,
                fillColor: WidgetStatePropertyAll(theme.colorScheme.onPrimary),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity(horizontal: 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.72,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        task.title ?? "",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.72,
                    child: ExpandableText(content: task.content),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EditDialog(
                        title: title,
                        description: description,
                        onTap: () async {
                          final response = await sl<UpdateTaskUseCase>().call(
                            params: TaskEntity(
                              id: task.id,
                              content: description.text,
                              title: title.text,
                              date: task.date,
                              category: task.category,
                              priority: task.priority,
                              uid: task.uid,
                            ),
                          );

                          response.fold(
                            (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Lỗi: $e")),
                              );
                            },
                            (r) {
                              Navigator.pop(context); // đóng dialog
                              setState(() {}); // refresh UI nếu cần
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(r.toString())),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Task Components
                  TaskComponent(
                    icon: const Icon(Icons.timer_outlined),
                    onTap: () async {
                      final result = await showDialog<DateTime>(
                        context: context,
                        builder: (context) {
                          return CalenderDialog(date: calendarController);
                        },
                      );
                      if (result != null) {
                        setState(() {
                          date = result;
                        });
                      }
                    },
                    title: "Task Time:",
                    content: Text(
                      (date ?? task.date) != null
                          ? formatPublishedDate(date ?? task.date!)
                          : "Chưa đặt",
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                  spacing,
                  TaskComponent(
                    icon: const Icon(Icons.tag),
                    onTap: () async {
                      category = await showDialog(
                        context: context,
                        builder: (context) {
                          return ChooseCategoryDialog();
                        },
                      );
                      setState(() {});
                    },
                    title: "Task Category:",
                    content:
                        category != null
                            ? Row(
                              children: [
                                Icon(
                                  category!.icon,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  category?.name ?? "",
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            )
                            : Icon(Icons.add),
                    category: category,
                  ),
                  spacing,
                  TaskComponent(
                    icon: const Icon(Icons.flag_outlined),
                    title: "Task Priority:",
                    content: Text(
                      priorityController.text != ""
                          ? priorityController.text
                          : "Default",
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return TaskPriorityDialog(
                            priority: priorityController,
                          );
                        },
                      );
                      setState(() {});
                    },
                  ),
                  spacing,
                  TaskComponent(
                    icon: const Icon(Icons.leaderboard_outlined),
                    title: "Sub - Task:",
                    content: Text(
                      "Add Sub - Task",
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                  spacing,
                  TaskComponent(
                    title: 'Delete Task',
                    icon: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog(
                              onTap: () async {
                                final response = await sl<DeleteTaskUseCase>()
                                    .call(params: task.id);
                                response.fold(
                                  (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  (r) {
                                    AppNavigator.pop(context);
                                    AppNavigator.pop(context);
                                  },
                                );
                              },
                              task: task,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete_forever_outlined),
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final int? priority = priorityController.text.isEmpty?null:int.parse(priorityController.text);
                        final response = await sl<UpdateTaskUseCase>().call(
                          params: TaskEntity(
                            id: task.id,
                            content: description.text,
                            title: title.text,
                            date: date,
                            category: category,
                            priority: priority,
                            uid: task.uid,
                          ),
                        );
                        response.fold(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Lỗi: $e"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          (r) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Cập nhật thành công"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      child: const Text(
                        "Edit Task",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
