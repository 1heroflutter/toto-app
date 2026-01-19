import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final int color;

  CategoryModel({required this.name, required this.icon, required this.color});
}

class TaskModel {
  final String? id;
  final String? uid;
  final bool? isDone;
  final String? title;
  final String content;
  final DateTime? date;
  final CategoryModel? category;
  final int? priority;
  TaskModel({
    this.id,
     this.uid,
    this.isDone,
    this.title,
    required this.content,
    this.date,
    this.category,
    this.priority,
  });

  factory TaskModel.fromSnapshot(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      uid: json["uid"] as String,
      isDone: json['isDone'],
      title: json["title"],
      content: json["content"],
      date: json['date'] != null ? (json['date'] as Timestamp).toDate() : null,
      category:
          json["taskCategory"] != null
              ? CategoryModel(
                name: json["taskCategory"]["name"],
                icon: IconData(
                  json["taskCategory"]["icon"],
                  fontFamily: 'MaterialIcons',
                ),
                color: json["taskCategory"]["color"] ?? Colors.grey.value,
              )
              : null,
      priority: json["priority"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid":uid,
      "isDone": isDone,
      "title": title,
      "content": content,
      "date": date != null ? Timestamp.fromDate(date!) : null,
      "taskCategory":
          category != null
              ? {
                "name": category!.name,
                "icon": category!.icon.codePoint,
                "color": category!.color,
              }
              : null,
      "priority": priority,
    };
  }
}
