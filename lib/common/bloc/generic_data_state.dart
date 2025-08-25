abstract class GenericDataState{}
class DataLoading extends GenericDataState{}
class DataLoaded<T> extends GenericDataState{
  final List<T> data;
  DataLoaded({required this.data});
}
class FailureLoadData extends GenericDataState{
  final String errorMessage;
  FailureLoadData({required this.errorMessage});
}