import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/common/bloc/generic_data_state.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/get_all_task.dart';

class TaskCubit extends Cubit<GenericDataState> {
  final GetAllTaskUseCase getAll;
  StreamSubscription? _subscription;
  List<TaskEntity> _allTasks = [];

  TaskCubit(this.getAll) : super(DataLoading());

  void getTasks() async {
    final stream = await getAll();
    _subscription = stream.listen((either) {
      either.fold((e) => emit(FailureLoadData(errorMessage: e)), (tasks) {
        _allTasks = tasks;
        emit(DataLoaded(data: tasks));
      });
    });
  }

  void searchTasks(String keyword) {
    if (keyword.isEmpty) {
      emit(DataLoaded(data: _allTasks));
    } else {
      final filtered =
          _allTasks
              .where(
                (task) =>
                    task.title!.toLowerCase().contains(keyword.toLowerCase()) ||
                    task.content.toLowerCase().contains(keyword.toLowerCase()),
              )
              .toList();
      emit(DataLoaded(data: filtered));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
