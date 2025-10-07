import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytodoapp/data/task/models/task.dart';

import '../../../domain/task/entities/task_entity.dart';
import '../../notify/sources/local_notification_service.dart';

abstract class TaskService {
  Future<Either> addNewTask(TaskEntity task, String uid);

  Stream<Either> getAllTask(String uid);

  Future<Either> getTaskByDate(DateTime date, bool isDone, String uid);

  Future<Either> deleteTask(String id);

  Future<Either> updateTask(TaskEntity task, String uid);

  Future<Either> isDone(String id, bool isDone);
}

class TaskSeviceImpl extends TaskService {
  final FirebaseFirestore firebaseStorage = FirebaseFirestore.instance;

  Future<Either> addNewTask(TaskEntity task, String uid) async {
    try {
      final taskModel = TaskModel(
        title: task.title,
        isDone: false,
        content: task.content,
        date: task.date,
        category:
            task.category != null
                ? CategoryModel(
                  name: task.category!.name,
                  icon: task.category!.icon,
                  color: task.category!.color,
                )
                : null,
        priority: task.priority,
        uid: uid,
      );

      final docRef = await firebaseStorage
          .collection("tasks")
          .add(taskModel.toJson());

      // Schedule notification nếu task có date
      if (task.date != null) {
        final now = DateTime.now();
        final scheduled = task.date!;
        if (scheduled.isAfter(now.add(const Duration(seconds: 5)))) {
          await LocalNotificationService.scheduleNotification(
            id: docRef.id.hashCode,
            title: task.title ?? "Task Reminder",
            body: task.content ?? "",
            scheduledDate: scheduled,
          );
        } else {
          print("⏰ Task '${task.title}' có thời gian trong quá khứ, bỏ qua notification.");
        }
      }
      return Right("Tạo mới thành công!");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> deleteTask(String id) async {
    try {
      await firebaseStorage.collection("tasks").doc(id).delete();
      return Right("Xóa thành công");
    } catch (e) {
      return Left("Lỗi khi xóa task: $e");
    }
  }

  Future<Either> updateTask(TaskEntity task, String uid) async {
    try {
      final taskModel = TaskModel(
        title: task.title,
        content: task.content,
        date: task.date,
        category:
            task.category != null
                ? CategoryModel(
                  name: task.category!.name,
                  icon: task.category!.icon,
                  color: task.category!.color,
                )
                : null,
        priority: task.priority,
        uid: uid,
      );

      await firebaseStorage
          .collection("tasks")
          .doc(task.id)
          .set(taskModel.toJson(), SetOptions(merge: true));

      // Schedule notification
      if (task.date != null) {
        final now = DateTime.now();
        final scheduled = task.date!;
        if (scheduled.isAfter(now.add(const Duration(seconds: 5)))) {
          await LocalNotificationService.scheduleNotification(
            id: task.id!.hashCode,
            title: task.title ?? "Task Reminder",
            body: task.content ?? "",
            scheduledDate: scheduled,
          );
        } else {
          print("⏰ Task '${task.title}' có thời gian trong quá khứ, bỏ qua notification.");
        }
      }
      return Right("Cập nhập thành công!");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> isDone(String id, bool isDone) async {
    try {
      await firebaseStorage.collection("tasks").doc(id).update({
        "isDone": isDone,
      });
      return Right("");
    } catch (e) {
      return Left("Lỗi khi cập nhật trạng thái: $e");
    }
  }

  @override
  Stream<Either> getAllTask(String uid) async* {
    try {
      final snapshot =
          firebaseStorage
              .collection("tasks")
              .where("uid", isEqualTo: uid)
              .snapshots();
      await for (final docs in snapshot) {
        yield Right(docs.docs);
      }
    } catch (e) {
      yield Left(e);
    }
  }

  @override
  Future<Either> getTaskByDate(DateTime date, bool isDone, String uid) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    try {
      final returnData =
          await firebaseStorage
              .collection("tasks")
              .where(
                "date",
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
              )
              .where("date", isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
              .where("isDone", isEqualTo: isDone)
              .where("uid", isEqualTo: uid)
              .get();
      return Right(returnData);
    } catch (e) {
      return Left(e);
    }
  }
}
