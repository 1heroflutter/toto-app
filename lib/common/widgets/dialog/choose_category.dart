import 'package:flutter/material.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

import '../../../data/task/models/task.dart';

class ChooseCategoryDialog extends StatefulWidget {
  const ChooseCategoryDialog({super.key});

  @override
  State<ChooseCategoryDialog> createState() => _ChooseCategoryDialogState();
}

class _ChooseCategoryDialogState extends State<ChooseCategoryDialog> {
  final List<CategoryEntity> listCategory = [
    CategoryEntity(
      name: 'Cook',
      icon: Icons.soup_kitchen_outlined,
      color: Colors.red.value,
    ),
    CategoryEntity(
      name: 'Work',
      icon: Icons.business_center_outlined,
      color: Colors.grey.value,
    ),
    CategoryEntity(
      name: 'Sport',
      icon: Icons.sports_soccer,
      color: Colors.greenAccent.value,
    ),
    CategoryEntity(
      name: 'Design',
      icon: Icons.design_services,
      color: Colors.orange.value,
    ),
    CategoryEntity(
      name: 'Study',
      icon: Icons.school_outlined,
      color: Colors.purple.value,
    ),
    CategoryEntity(
      name: 'Social',
      icon: Icons.facebook,
      color: Colors.teal.value,
    ),
    CategoryEntity(
      name: 'Music',
      icon: Icons.music_note_outlined,
      color: Colors.brown.value,
    ),
    CategoryEntity(
      name: 'Health',
      icon: Icons.health_and_safety_outlined,
      color: Colors.pink.value,
    ),
    CategoryEntity(
      name: 'Movie',
      icon: Icons.movie_creation_outlined,
      color: Colors.indigo.value,
    ),
    CategoryEntity(
      name: 'Home',
      icon: Icons.home_outlined,
      color: Colors.cyan.value,
    ),
    CategoryEntity(
      name: 'Create New',
      icon: Icons.add,
      color: Colors.green.value,
    ),
  ];
  late CategoryEntity? selected = listCategory[1] ;

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
                    final isSelected = selected?.name == category.name;

                    return GestureDetector(
                      onTap:
                          () => setState(() {
                            selected = CategoryEntity(
                              name: category.name,
                              icon: category.icon,
                              color: category.color,
                            );
                          }),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  isSelected
                                      ? theme.primaryColor
                                      : Color(category.color),
                            ),
                            child: Icon(
                              category.icon,
                              color:
                                  isSelected
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
                    backgroundColor: WidgetStatePropertyAll(theme.primaryColor),
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
