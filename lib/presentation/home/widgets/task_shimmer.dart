import 'package:flutter/material.dart';
import 'package:mytodoapp/common/widgets/loaders/shimmer.dart';

class TaskShimmer extends StatelessWidget {
  final int itemCount;

  const TaskShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
       return ShimmerEffect(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemCount: itemCount,
    );
  }
}
