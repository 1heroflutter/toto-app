import 'package:flutter/material.dart';


class BasicAppBar extends StatelessWidget {
  final Widget? title;
  final IconData? icon;
  final VoidCallback? onLeadingTap;
  final List<IconButton>? suffer;

  const BasicAppBar({
    super.key,
    this.icon,
    this.title,
    this.onLeadingTap,
    required this.suffer,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      surfaceTintColor: theme.colorScheme.onSecondaryContainer,
      toolbarHeight: 50,
      backgroundColor: theme.colorScheme.onSecondaryContainer,
      leading:
          icon != null
              ? IconButton(
                onPressed: onLeadingTap,
                icon: Icon(
                  icon,
                  size: 22,
                  color: theme.colorScheme.onPrimary,
                ),
              )
              : Container(),
      centerTitle: true,
      title: title ?? Container(),
      actions:
        suffer!=null&&suffer!.isNotEmpty?suffer :[Container()],
    );
  }
}
