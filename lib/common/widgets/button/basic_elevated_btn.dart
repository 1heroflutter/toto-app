import 'package:flutter/material.dart';

class BasicElevatedBtn extends StatelessWidget {
  final AssetImage image;
  final String label;
  final VoidCallback onPress;

  const BasicElevatedBtn({
    super.key,
    required this.label,
    required this.onPress,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height:  MediaQuery.of(context).size.height * 0.06,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPress;
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SizedBox(height: 24,width: 24,child: Image(image: image),),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
