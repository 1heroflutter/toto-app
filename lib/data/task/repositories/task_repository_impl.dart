import 'package:dartz/dartz.dart';
import 'package:mytodoapp/common/helper/mapper.dart';
import 'package:mytodoapp/data/task/models/task.dart';
import 'package:mytodoapp/data/task/sources/task_service_impl.dart';
import 'package:mytodoapp/domain/task/repositories/task_repository.dart';

import '../../../domain/task/entities/task_entity.dart';
import '../../../service_locator.dart';

class TaskRepositoryImpl extends TaskRepository {
  @override
  Future<Either> addNewTask(TaskEntity task) async {
    return await sl<TaskService>().addNewTask(task);
  }

  @override
  Stream<Either> getAllTask() {
    return sl<TaskService>().getAllTask().map((response) {
      return response.fold((e) => Left(e), (r) {
        var tasks =
            List.from(r)
                .map((doc) => TaskMapper.toEntity(TaskModel.fromSnapshot(doc)))
                .toList();
        return Right(tasks);
      });
    });
  }

  @override
  Future<Either> deleteTask(String id) async {
    return await sl<TaskService>().deleteTask(id);
  }

  @override
  Future<Either> updateTask(TaskEntity task) async {
    return await sl<TaskService>().updateTask(task);
  }

  @override
  Future<Either> isDone(String id, bool isDone) async {
    return await sl<TaskService>().isDone(id, isDone);
  }

  @override
  Future<Either> getTaskByDate(DateTime date, bool isDone) async {
    var response = await sl<TaskService>().getTaskByDate(date, isDone);
    return response.fold((e) => Left(e), (data) {
      final tasks =
          data.docs
              .map<TaskEntity>(
                (doc) => TaskMapper.toEntity(TaskModel.fromSnapshot(doc)),
              )
              .toList();

      return Right(tasks);
    });
  }


}
