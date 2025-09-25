import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:mytodoapp/common/helper/app_navigator.dart';
import 'package:mytodoapp/common/widgets/dialog/calender.dart';
import 'package:mytodoapp/common/widgets/dialog/choose_category.dart';
import 'package:mytodoapp/common/widgets/dialog/task_priority.dart';
import 'package:mytodoapp/common/widgets/textfield/dialog_textfield.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/add_task.dart';

import '../../../service_locator.dart';

class AddDialog extends StatefulWidget {
  AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late TextEditingController title;
  late TextEditingController description;
  String? _titleError;
  String? _desError;

  late AdvancedCalendarController calendarController;
  CategoryEntity? categoryEntity;
  late TextEditingController priority ;
  DateTime? time;
  @override
  void initState(){
    super.initState();
    title = TextEditingController();
    description = TextEditingController();
    calendarController = AdvancedCalendarController(DateTime.now());
    priority = TextEditingController();
  }
  @override
  void dispose(){
    title.dispose();
    description.dispose();
    calendarController.dispose();
    priority.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(18),
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
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
                  fontSize: 20,
                ),
              ),
              BasicTextField(
                controller: title,
                label: "Title",
                errorText: _titleError,
              ),
              BasicTextField(
                controller: description,
                label: "Description",
                errorText: _desError,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      final selectedTime = await showDialog<DateTime>(
                        context: context,
                        builder: (context) {
                          return CalenderDialog(
                            date: calendarController,
                          );
                        },
                      );
                      print('[SELECTEDTIME]:$selectedTime');

                      if (selectedTime != null) {
                        setState(() {
                          time = selectedTime;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.timer_outlined,
                      size: 22,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      CategoryEntity category = await showDialog(
                        context: context,
                        builder: (context) {
                          return ChooseCategoryDialog();
                        },
                      );
                      if (category != null) {
                        setState(() {
                          categoryEntity = category;
                        });
                      } else {
                        category = CategoryEntity(
                          name: 'Cook',
                          icon: Icons.soup_kitchen_outlined,
                          color: Colors.red.value,
                        );
                        setState(() {
                          categoryEntity = category;
                        });
                      }
                      print('[Category]:$category');
                    },
                    icon: Icon(
                      Icons.tag,
                      size: 22,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return TaskPriorityDialog(priority: priority);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.flag_outlined,
                      size: 22,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      _titleError = null;
                      _desError = null;
                      if (title.text.isEmpty) {
                        setState(() {
                          _titleError = "Tiêu đề không dược để trống!";
                        });
                        return;
                      } else {
                        setState(() {
                          _titleError = null;
                        });
                      }
                      if (description.text.isEmpty) {
                        setState(() {
                          _desError = "Nội dung không dược để trống!";
                        });
                        return;
                      } else {
                        setState(() {
                          _desError = null;
                        });
                      }
                      final response = await sl<AddTaskUseCase>().call(
                        params: TaskEntity(
                          title: title.text,
                          content: description.text,
                          category: categoryEntity,
                          date: calendarController.value,
                          priority:
                              priority.text.isNotEmpty
                                  ? int.parse(priority.text)
                                  : null, uid: ,
                        ),
                      );
                      AppNavigator.pop(context);
                      response.fold(
                        (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        (r) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(r),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.send, size: 22, color: theme.primaryColor),
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
