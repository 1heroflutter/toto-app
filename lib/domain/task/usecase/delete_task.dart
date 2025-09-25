import 'package:dartz/dartz.dart';
import 'package:mytodoapp/core/usecase/usecase.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/repositories/task_repository.dart';

import '../../../service_locator.dart';

class DeleteTaskUseCase extends UseCase<Either, String>{
  @override
  Future<Either> call({String? params}) async {
    return await sl<TaskRepository>().deleteTask(params!);
  }

}