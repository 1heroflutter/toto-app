import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/usecase/usecase.dart';
import 'generic_data_state.dart';

class GenericDataCubit extends Cubit<GenericDataState> {
  GenericDataCubit() : super(DataLoading());

  void getData<T>(UseCase useCase, {dynamic params}) async {
    var returnedData = await useCase.call(params: params);
    returnedData.fold(
      (error) {
        emit(FailureLoadData(errorMessage: error));
      },
      (data) {
        emit(DataLoaded(data: data));
      },
    );
  }
}
