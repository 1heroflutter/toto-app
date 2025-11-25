import 'package:flutter/material.dart';
import 'package:mytodoapp/common/widgets/bottomSheet/task_add_bottom_sheet.dart';
import 'package:mytodoapp/common/widgets/dialog/add.dart';
import 'package:mytodoapp/presentation/assistant/pages/assistant_page.dart';
import 'package:mytodoapp/presentation/edit/pages/edit_page.dart';
import '../../calendar/pages/calendar_page.dart';
import '../../focus/pages/focus_page.dart';
import '../../home/pages/home_page.dart';
import '../../profile/pages/profile_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return  HomePage();
      case 1:
        return const CalendarPage();
      case 2:
        return const AssistantPage();
      case 3:
        return ProfilePage();
      default:
        return  HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: _currentIndex!=2?FloatingActionButton(
        backgroundColor: theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: theme.colorScheme.background,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const TaskAddBottomSheet(),
              );
            },
          );

        },

        child: const Icon(Icons.add),
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color:
                    _currentIndex == 0
                        ? theme.primaryColor
                        : theme.colorScheme.onPrimary,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month,
                color:
                    _currentIndex == 1
                        ? theme.primaryColor
                        : theme.colorScheme.onPrimary,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: Icon(
                Icons.auto_awesome,
                color:
                    _currentIndex == 2
                        ? theme.primaryColor
                        : theme.colorScheme.onPrimary,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_outline_rounded,
                color:
                    _currentIndex == 3
                        ? theme.primaryColor
                        : theme.colorScheme.onPrimary,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      body: _getPage(_currentIndex),
    );
  }
}
