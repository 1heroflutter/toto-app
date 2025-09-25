import 'package:dartz/dartz.dart';
import 'package:mytodoapp/core/usecase/usecase.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/repositories/task_repository.dart';

import '../../../service_locator.dart';
class GetTaskByDateParams {
  final DateTime date;
  final bool isDone;

  GetTaskByDateParams({
    required this.date,
    required this.isDone,
  });
}

class GetTaskByDateTaskUseCase extends UseCase<Either, GetTaskByDateParams> {
  @override
  Future<Either> call({GetTaskByDateParams? params}) async {
    return await sl<TaskRepository>()
        .getTaskByDate(params!.date, params.isDone);
  }
}
