import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/common/bloc/generic_data_cubit.dart';
import 'package:mytodoapp/common/bloc/generic_data_state.dart';
import 'package:mytodoapp/common/widgets/appbar/basic_appbar.dart';
import 'package:mytodoapp/common/widgets/task_is_empty.dart';
import 'package:mytodoapp/common/widgets/list_task.dart';
import 'package:mytodoapp/common/widgets/search_bar.dart';
import 'package:mytodoapp/common/widgets/task.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/get_all_task.dart';
import 'package:mytodoapp/presentation/home/bloc/task_cubit.dart';

import '../../../core/config/assets/app_images.dart';
import '../../../service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<TaskEntity> listTask;

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: MediaQuery.of(context).size.height * 0.02);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          icon: Icons.sort,
          title: Text(
            'Index',
            style: TextStyle(color: theme.colorScheme.onPrimary),
          ),
          onLeadingTap: () {},
          suffer: null,
        ),
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          space,
          BlocBuilder<TaskCubit, GenericDataState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DataLoaded) {
                if (state.data != null && state.data.isNotEmpty) {
                  listTask = state.data;
                  return Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTask(tasks: state.data),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(child: Center(child: TaskIsEmpty()));
                }
              }
              if (state is FailureLoadData) {
                return Center(child: Text(state.errorMessage));
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
