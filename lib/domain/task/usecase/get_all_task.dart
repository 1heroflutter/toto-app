import 'package:dartz/dartz.dart';
import 'package:mytodoapp/core/usecase/usecase.dart';
import 'package:mytodoapp/domain/task/repositories/task_repository.dart';

import '../../../service_locator.dart';

class GetAllTaskUseCase extends UseCase<Stream<Either>,dynamic>{
  @override
  Future<Stream<Either>> call({params}) async {
    return sl<TaskRepository>().getAllTask();
  }

}