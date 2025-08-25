import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/task_item.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  // giả lập task theo ngày
  final Map<DateTime, List<String>> tasks = {
    DateTime.utc(2025, 8, 24): [
      "Do Math Homework",
      "Business meeting with CEO",
    ],
    DateTime.utc(2025, 8, 25): ["Tack out dogs"],
  };

  List<String> _getTasksForDay(DateTime day) {
    return tasks[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: Column(
        children: [
          // --- Calendar ---
          AdvancedCalendar(
            controller: AdvancedCalendarController(DateTime.now()),
            startWeekDay: 1,
            events: [
              DateTime(2025, 8, 24),
              DateTime(2025, 8, 25),
            ], // ngày nào có task thì add vào đây
          ),

          const SizedBox(height: 12),

          // --- Today / Completed buttons ---
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Today"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Completed"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),


        ],
      ),
    );
  }
}
