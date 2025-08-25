import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:mytodoapp/common/widgets/dialog/calender.dart';
import 'package:mytodoapp/common/widgets/dialog/choose_category.dart';
import 'package:mytodoapp/common/widgets/dialog/task_priority.dart';
import 'package:mytodoapp/common/widgets/textfield/basicTextfield.dart';
import 'package:mytodoapp/common/widgets/textfield/dialog_textfield.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController description;

  const AddDialog({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final AdvancedCalendarController calendarController =
    AdvancedCalendarController(DateTime.now());
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
              BasicDialogTextField(controller: title, label: "Title"),
              BasicDialogTextField(
                controller: description,
                label: "Description",
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
                          return CalenderDialog(controller: calendarController);
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
                        context: context, builder: (context) {
                        return ChooseCategoryDialog();
                      },);
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
                      final priority = await showDialog(
                        context: context,
                        builder: (context) {
                          return TaskPriorityDialog();
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
                    onPressed: () {},
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
