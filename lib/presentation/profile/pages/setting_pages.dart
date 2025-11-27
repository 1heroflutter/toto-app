import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodoapp/common/helper/app_navigator.dart';

import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../core/config/theme/color_notifier.dart';
import '../widgets/basic_headline.dart';

class SettingPages extends ConsumerWidget {
  const SettingPages({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          icon: Icons.navigate_before,
          title: const Text('Settings'),
          onLeadingTap: (){AppNavigator.pop(context);},
          suffer: null,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicHeadline(text: "Settings"),

                  _settingBtn(
                    Icons.color_lens_outlined,
                    "Change app color",
                    theme,
                    IconButton(
                      onPressed: () {
                        _showColorPickerDialog(context, ref);
                      },
                      icon: const Icon(Icons.navigate_next, size: 20),
                    ),
                        () {
                      _showColorPickerDialog(context, ref);
                    },
                  ),
                  _settingBtn(
                    Icons.font_download_outlined,
                    "Change app typography",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next, size: 20),
                    ),
                        () {},
                  ),
                  _settingBtn(
                    Icons.language_outlined,
                    "Change app language",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next, size: 20),
                    ),
                        () {},
                  ),

                  BasicHeadline(text: "Import"),
                  _settingBtn(
                    Icons.download,
                    "Import from Google calendar",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                        () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingBtn(
      IconData icon,
      String content,
      ThemeData theme,
      IconButton? suffer,
      VoidCallback onPress,
      ) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        child: Row(
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 4),
            Text(
              content,
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            suffer ?? Container(),
          ],
        ),
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context, WidgetRef ref) {
    Color currentColor = ref.read(colorNotifierProvider);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Change app color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                currentColor = color;
              },
              enableAlpha: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Chọn"),
              onPressed: () {
                ref.read(colorNotifierProvider.notifier).setColor(currentColor);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
