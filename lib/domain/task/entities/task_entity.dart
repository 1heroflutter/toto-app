import 'package:flutter/cupertino.dart';

class TaskEntity {
  final String? id;
  final String? uid;
  final bool? isDone;
  final String? title;
  final String content;
  final DateTime? date;
  final CategoryEntity? category;
  final int? priority;

  TaskEntity({
    this.id,
     this.uid,
    this.isDone,
    this.title,
    required this.content,
    this.date,
    this.category,
    this.priority,
  });
}

class CategoryEntity {
  final String name;
  final IconData icon;
  final int color;

  CategoryEntity({required this.name, required this.icon, required this.color});
}
