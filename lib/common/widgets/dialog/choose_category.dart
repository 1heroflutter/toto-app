import 'package:flutter/material.dart';

import '../../../data/task/models/category.dart';

class ChooseCategoryDialog extends StatefulWidget {
  const ChooseCategoryDialog({super.key});

  @override
  State<ChooseCategoryDialog> createState() => _ChooseCategoryDialogState();
}
class _ChooseCategoryDialogState extends State<ChooseCategoryDialog> {
  String? selected;
  final List<Color> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
  ];
  Color getRandomColor(int index) {
    return availableColors[index % availableColors.length];
  }
  final List<TaskCategory> listCategory = [
    TaskCategory(name: 'Cook', icon: Icons.soup_kitchen_outlined),
    TaskCategory(name: 'Work', icon: Icons.business_center_outlined),
    TaskCategory(name: 'Sport', icon: Icons.sports_soccer),
    TaskCategory(name: 'Design', icon: Icons.design_services),
    TaskCategory(name: 'Study', icon: Icons.school_outlined),
    TaskCategory(name: 'Social', icon: Icons.facebook),
    TaskCategory(name: 'Music', icon: Icons.music_note_outlined),
    TaskCategory(name: 'Health', icon: Icons.health_and_safety_outlined),
    TaskCategory(name: 'Movie', icon: Icons.movie_creation_outlined),
    TaskCategory(name: 'Home', icon: Icons.home_outlined),
    TaskCategory(name: 'Create New', icon: Icons.add),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(width: 2, color: theme.colorScheme.onSecondary),
      ),
      backgroundColor: theme.colorScheme.background,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                "Choose Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(listCategory.length, (index) {
                    final category = listCategory[index];
                    final color = getRandomColor(index);
                    final isSelected = selected == category.name;

                    return GestureDetector(
                      onTap: () => setState(() => selected = category.name),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: isSelected
                                  ? theme.primaryColor
                                  : color,
                            ),
                            child: Icon(
                              category.icon,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category.name,
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStatePropertyAll(theme.primaryColor),
                  ),
                  onPressed: () => Navigator.pop(context, selected),
                  child: Text(
                    "Add Category",
                    style: TextStyle(color: theme.colorScheme.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
