import 'package:flutter/material.dart';
import 'package:mytodoapp/common/widgets/task.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

class ListTask extends StatefulWidget {
  final List<TaskEntity> tasks;

  const ListTask({super.key, required this.tasks});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              TaskItemWidget(task: widget.tasks[index]),
              SizedBox(height:  MediaQuery.of(context).size.height * 0.02,)
            ],
          ),
        );
      },
    );
  }
}
