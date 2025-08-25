import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Radio(value:, fillColor: WidgetStatePropertyAll(theme.primaryColor),),
        SizedBox(width: MediaQuery
            .of(context)
            .size
            .width * 0.02),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Title", maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary),),
            Spacer(),
            Row(
              children: [
                Text(
                  "21/8/2025", style: TextStyle(fontWeight: FontWeight.w400),),
                Spacer(),
                ElevatedButton(onPressed: () {},
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8))),
                      backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.business_center_outlined),
                        Text("Category")
                      ],)),
                SizedBox(width: 4,),
                ElevatedButton(onPressed: () {},
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: BorderSide(
                                width: 1, color: theme.primaryColor)))
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.flag_outlined),
                        Text("1")
                      ],))
              ],
            )
          ],
        ),
      ],
    );
  }
}
