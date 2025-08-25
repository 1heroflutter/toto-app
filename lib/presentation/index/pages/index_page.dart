import 'package:flutter/material.dart';
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
  final List<Widget> _pages = const [
    HomePage(),
    CalendarPage(),
    FocusPage(),
    ProfilePage(),
  ];
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
          showDialog(
            context: context,
            builder: (context) {
              return AddDialog(
                title: TextEditingController(),
                description: TextEditingController(),
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
      body: IndexedStack(index: _currentIndex, children: _pages),
    );
  }
}
