import 'package:dartz/dartz.dart';
import 'package:mytodoapp/common/helper/mapper.dart';
import 'package:mytodoapp/data/task/models/task.dart';
import 'package:mytodoapp/data/task/sources/task_service_impl.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';
import 'package:mytodoapp/domain/task/repositories/task_repository.dart';

import '../../../domain/task/entities/task_entity.dart';
import '../../../service_locator.dart';

class TaskRepositoryImpl extends TaskRepository {
  @override
  Future<Either> addNewTask(TaskEntity task) async {
    final user = await sl<AuthRepository>().loadUser();
    if(user == null || user.uid == null){
      return left("Not logged in, Cannot create task!");
    }
    return await sl<TaskService>().addNewTask(task,user.uid!);
  }

  @override
  Stream<Either<Object, List<TaskEntity>>> getAllTask() async* {
    final user = await sl<AuthRepository>().loadUser();
    if (user == null || user.uid == null) {
      yield Left("Not logged in, Cannot create task!");
      return;
    }
    yield* sl<TaskService>().getAllTask(user.uid!).map((response) {
      return response.fold(
            (e) => Left(e),
            (r) {
          final tasks = List.from(r)
              .map((doc) => TaskMapper.toEntity(TaskModel.fromSnapshot(doc)))
              .toList();
          return Right(tasks);
        },
      );
    });
  }


  @override
  Future<Either> deleteTask(String id) async {
    return await sl<TaskService>().deleteTask(id);
  }

  @override
  Future<Either> updateTask(TaskEntity task) async {
    final user = await sl<AuthRepository>().loadUser();
    if(user == null || user.uid == null){
      return left("Not logged in, Cannot create task!");
    }
    return await sl<TaskService>().updateTask(task,user.uid!);
  }

  @override
  Future<Either> isDone(String id, bool isDone) async {
    return await sl<TaskService>().isDone(id, isDone);
  }

  @override
  Future<Either> getTaskByDate(DateTime date, bool isDone) async {
    final user = await sl<AuthRepository>().loadUser();
    if(user == null || user.uid == null){
      return left("Not logged in, Cannot create task!");
    }
    var response = await sl<TaskService>().getTaskByDate(date, isDone, user.uid!);
    return response.fold((e) => Left(e.toString()), (data) {
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
