import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';

class CalenderDialog extends StatefulWidget {
  final AdvancedCalendarController date;
  const CalenderDialog({super.key, required this.date});

  @override
  State<CalenderDialog> createState() => _CalenderDialogState();
}

class _CalenderDialogState extends State<CalenderDialog> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: AdvancedCalendar(
                controller: widget.date,
                startWeekDay: 1,
                events: [],

              ),
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
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        theme.primaryColor,
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                      onPressed: () async {
                        selectedDate = widget.date.value;
                        if (selectedDate != null) {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            final DateTime fullDateTime = DateTime(
                              selectedDate!.year,
                              selectedDate!.month,
                              selectedDate!.day,
                              picked.hour,
                              picked.minute,
                            );
                            Navigator.pop(
                              context,
                              fullDateTime,
                            );
                          }
                        }
                      }

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
