import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/core/config/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double width, height, radius;
  final Color? color;

  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 10,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (isDark ? Colors.grey : Colors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
