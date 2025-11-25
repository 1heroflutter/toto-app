import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/presentation/home/bloc/task_cubit.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController content;

  @override
  void initState() {
    super.initState();
    content = TextEditingController(text: "");
    content.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: SearchBar(
        controller: content,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          context.read<TaskCubit>().searchTasks(value);
        },
        leading:
            content.text.isEmpty
                ? IconButton(icon: Icon(Icons.search), onPressed: () {})
                : IconButton(
                  onPressed: () {
                    setState(() {
                      content.clear();
                    });
                    context.read<TaskCubit>().getTasks();
                  },
                  icon: Icon(Icons.close),
                ),

        hintText: "Search for your task...",
        backgroundColor: WidgetStatePropertyAll(theme.colorScheme.background),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.primaryColor),
          ),
        ),
      ),
    );
  }
}
