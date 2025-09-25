import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';

import '../../../domain/task/entities/task_entity.dart';
import '../../../domain/task/usecase/add_task.dart';
import '../../../service_locator.dart';
import '../../helper/app_navigator.dart';
import '../dialog/calender.dart';
import '../dialog/choose_category.dart';
import '../dialog/task_priority.dart';
import '../textfield/dialog_textfield.dart';

class BasicBottomSheet extends StatefulWidget {
  const BasicBottomSheet({super.key});

  @override
  State<BasicBottomSheet> createState() => _BasicBottomSheetState();
}

class _BasicBottomSheetState extends State<BasicBottomSheet> {
  TextEditingController title = TextEditingController();

   TextEditingController description = TextEditingController();

  String? _titleError;

  String? _desError;

  final AdvancedCalendarController calendarController =
  AdvancedCalendarController(DateTime.now());

  CategoryEntity? categoryEntity;

  final TextEditingController priority = TextEditingController();

  DateTime? time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.3,
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
          mainAxisSize: MainAxisSize.min,
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
                    final selectedDate = await showDialog(
                      context: context,
                      builder: (context) {
                        return CalenderDialog(
                          date: calendarController,
                        );
                      },
                    );
                    print("[date picker check]: $selectedDate");
                  },
                  icon: Icon(
                    Icons.timer_outlined,
                    size: 22,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final category = await showDialog(
                      context: context,
                      builder: (context) {
                        return ChooseCategoryDialog();
                      },
                    );
                    if (category != null) {
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
                        uid: ,
                        content: description.text,
                        category: categoryEntity,
                        date: calendarController.value,
                        priority:
                        priority.text.isNotEmpty
                            ? int.parse(priority.text)
                            : null,
                      ),
                    );
                    AppNavigator.pop(context);
                    response.fold((e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),

                        behavior: SnackBarBehavior.floating,
                      ));
                    }, (r) {
                    });
                  },
                  icon: Icon(Icons.send, size: 22, color: theme.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
