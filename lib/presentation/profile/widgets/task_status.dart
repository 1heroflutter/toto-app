import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

import '../../../common/bloc/generic_data_state.dart';
import '../../home/bloc/task_cubit.dart';

class TaskStatus extends StatelessWidget {
  const TaskStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TaskCubit, GenericDataState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is DataLoaded) {
            List<TaskEntity> tasks = state.data;
            List<TaskEntity?> left = [];
            List<TaskEntity?> done= [];
            tasks.forEach((task) {
              if (task.isDone != null) {
                if (task.isDone!) {
                  done.add(task);
                } else {
                  left.add(task);
                }
              }

            },);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "${left.length} Task left",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "${done.length} Task done",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ),
              ],
            );
        }
        if (state is FailureLoadData) {
          return Center(child: Text(state.errorMessage));
        }
        return Container();
      },
    );
  }
}
