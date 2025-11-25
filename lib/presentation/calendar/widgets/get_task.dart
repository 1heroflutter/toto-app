import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/common/bloc/generic_data_cubit.dart';
import 'package:mytodoapp/common/widgets/task_is_empty.dart';

import '../../../common/bloc/generic_data_state.dart';
import '../../../common/widgets/list_task.dart';
import '../../../core/config/assets/app_images.dart';
import '../../../domain/task/usecase/get_today_task.dart';
import '../../../service_locator.dart';
import '../../home/bloc/task_cubit.dart';
import '../../home/widgets/task_shimmer.dart';

class GetTask extends StatefulWidget {
  final DateTime date;
  final bool isDone;

  const GetTask({super.key, required this.date, required this.isDone});

  @override
  State<GetTask> createState() => _GetTaskState();
}

class _GetTaskState extends State<GetTask> {
  late final GenericDataCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = GenericDataCubit();
    cubit.getData(
      sl<GetTaskByDateTaskUseCase>(),
      params: GetTaskByDateParams(date: widget.date, isDone: widget.isDone),
    );
  }

  @override
  void didUpdateWidget(covariant GetTask oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date || oldWidget.isDone != widget.isDone) {
      cubit.getData(
        sl<GetTaskByDateTaskUseCase>(),
        params: GetTaskByDateParams(date: widget.date, isDone: widget.isDone),
      );
    }
  }
  @override
  void dispose(){
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<GenericDataCubit, GenericDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return Center(child: TaskShimmer(itemCount: 3,));
          }
          if (state is DataLoaded) {
            if (state.data != null && state.data.isNotEmpty) {
              return Flexible(
                child: SingleChildScrollView(
                  child: ListTask(tasks: state.data),
                ),
              );
            } else {
              return Center(
                child: TaskIsEmpty()
              );
            }
          }
          if (state is FailureLoadData) {
            return Center(child: Text(state.errorMessage));
          }
          return Container();
        },
      ),
    );
  }
}
