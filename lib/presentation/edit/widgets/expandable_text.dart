import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String content;

  const ExpandableText({super.key, required this.content});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {setState(() {
        _expand = !_expand;
      });
      },
      child: Text(
        widget.content,
        maxLines: _expand ? null : 1,
        overflow: _expand ? TextOverflow.visible : TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
