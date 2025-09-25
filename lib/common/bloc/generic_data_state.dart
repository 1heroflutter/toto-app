import 'package:mytodoapp/domain/task/entities/task_entity.dart';

abstract class GenericDataState{}
class DataLoading extends GenericDataState{}
class DataLoaded<T> extends GenericDataState{
  final List<TaskEntity> data;
  DataLoaded({required this.data});
}
class FailureLoadData extends GenericDataState{
  final String errorMessage;
  FailureLoadData({required this.errorMessage});
}