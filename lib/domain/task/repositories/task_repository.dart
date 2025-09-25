import 'package:dartz/dartz.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

abstract class TaskRepository{
  Future<Either> addNewTask(TaskEntity task);
  Stream<Either> getAllTask( );
  Future<Either> getTaskByDate(DateTime date, bool isDone);
  Future<Either> deleteTask(String id);
  Future<Either> updateTask(TaskEntity task);
  Future<Either> isDone(String id, bool isDone);
}