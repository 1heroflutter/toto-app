import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mytodoapp/common/helper/app_navigator.dart';
import 'package:mytodoapp/common/helper/formatPublishedDate.dart';
import 'package:mytodoapp/common/widgets/dialog/delete.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/domain/task/usecase/isDone_task.dart';
import 'package:mytodoapp/presentation/edit/pages/edit_page.dart';

import '../../domain/task/usecase/delete_task.dart';
import '../../service_locator.dart';

class TaskItemWidget extends StatefulWidget {
  final TaskEntity task;

  const TaskItemWidget({super.key, required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  late bool done;

  @override
  void initState() {
    super.initState();
    done = widget.task.isDone ?? false;
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Slidable(
      key: ValueKey(widget.task.id),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.45,
        children: [
          SlidableAction(
            onPressed: (context) {
              AppNavigator.push(context, EditPage(task: widget.task));
            },
            borderRadius: BorderRadius.circular(14),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),

          SlidableAction(
            onPressed: (context) async {
              showDialog(
                builder:
                    (context) => DeleteDialog(
                      onTap: () async {
                        final response = await sl<DeleteTaskUseCase>().call(
                          params: widget.task.id,
                        );
                        response.fold(
                              (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e, style: TextStyle(color: Colors.white)),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                              (r) {
                            if (context.mounted) {
                              AppNavigator.pop(context);
                            }
                          },
                        );

                      },
                      task: widget.task,
                    ),
                context: context,
              );
            },
            borderRadius: BorderRadius.circular(14),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) async {
              var response = await sl<IsDoneTaskUseCase>().call(
                params: widget.task.id,
                isDone: true
              );

              response.fold(
                    (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e),behavior: SnackBarBehavior.floating,),
                    );
                  }
                },
                    (r) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(r),behavior: SnackBarBehavior.floating,),
                        );
                      }
                    },
              );
            },
            borderRadius: BorderRadius.circular(14),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.check,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          AppNavigator.push(context, EditPage(task: widget.task));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: theme.colorScheme.primaryContainer,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Checkbox(
                value: done ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(100)),
                onChanged: (value) async {
                  if (value == null) return;
                  setState(() {
                   done= value;
                  });
                  await sl<IsDoneTaskUseCase>().call(
                    params: widget.task.id,
                    isDone: value,
                  );

                  if (!mounted) return;
                  // response.fold(
                  //       (e) => ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text(e)),
                  //   ),
                  //       (r) => ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text(r)),
                  //   ),
                  // );
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.task.title.toString(),
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        widget.task.date != null
                            ? Text(
                              formatPublishedDate(widget.task.date!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            )
                            : Container(),
                        const Spacer(),
                        widget.task.category != null
                            ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(widget.task.category!.color),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    widget.task.category!.icon,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    widget.task.category!.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                            : Container(),
                        const SizedBox(width: 4),
                        widget.task.priority != null
                            ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 1,
                                  color: theme.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flag_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    widget.task.priority.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
