import 'package:flutter/material.dart';
import 'package:mytodoapp/common/widgets/bottomSheet/basic_bottom_sheet.dart';
import 'package:mytodoapp/common/widgets/dialog/add.dart';
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
        return const HomePage();
      case 1:
        return const CalendarPage();
      case 2:
        return const FocusPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // cho phép sheet mở full height
            backgroundColor: theme.colorScheme.background,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const BasicBottomSheet(),
              );
            },
          );

        },

        child: const Icon(Icons.add),
      ),
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
                Icons.access_time_outlined,
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
