import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:mytodoapp/presentation/calendar/widgets/get_task.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/task.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  AdvancedCalendarController selectedDay = AdvancedCalendarController(
    DateTime.now(),
  );
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    selectedDay.addListener(_onDateChanged);
  }

  void _onDateChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    selectedDay.removeListener(_onDateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          icon: null,
          title: Text(
            "Calendar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          onLeadingTap: null,
          suffer: null,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            AdvancedCalendar(
              controller: selectedDay,
              startWeekDay: 1,
              events: [DateTime(2025, 8, 24), DateTime(2025, 8, 25)],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isDone = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        !isDone
                            ? theme.primaryColor
                            : theme.colorScheme.background,
                      ),
                    ),
                    child: Text(
                      "To Do",
                      style: TextStyle(
                        color: !isDone ? Colors.white : theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isDone = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        isDone
                            ? theme.primaryColor
                            : theme.colorScheme.background,
                      ),
                    ),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        color: isDone ? Colors.white : theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GetTask(date: selectedDay.value, isDone: isDone),
          ],
        ),
      ),
    );
  }
}
