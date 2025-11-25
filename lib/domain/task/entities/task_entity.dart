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

  const TaskEntity({
    this.id,
    this.uid,
    this.isDone,
    this.title,
    required this.content,
    this.date,
    this.category,
    this.priority,
  });

  TaskEntity copyWith({
    String? id,
    String? uid,
    bool? isDone,
    String? title,
    String? content,
    DateTime? date,
    CategoryEntity? category,
    int? priority,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }
}

class CategoryEntity {
  final String name;
  final IconData icon;
  final int color;

  const CategoryEntity({
    required this.name,
    required this.icon,
    required this.color
  });

  // Hàm copyWith
  CategoryEntity copyWith({
    String? name,
    IconData? icon,
    int? color,
  }) {
    return CategoryEntity(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}