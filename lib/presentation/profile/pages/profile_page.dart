import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodoapp/domain/auth/usecase/signout.dart';
import 'package:mytodoapp/presentation/auth/pages/signin.dart';
import 'package:mytodoapp/presentation/profile/pages/setting_pages.dart';
import 'package:mytodoapp/presentation/profile/widgets/basic_headline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../core/config/theme/theme_provider.dart';
import '../../../service_locator.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          icon: null,
          title: const Text('Profile'),
          onLeadingTap: null,
          suffer: null,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.account_circle_outlined, size: 100),
            ),
            Text(
              "Hoang Nhat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "X Task left",
                            style: TextStyle(color: theme.primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "X Task done",
                            style: TextStyle(color: theme.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BasicHeadline(text: "Settings"),

                  _settingBtn(
                    Icons.settings_outlined,
                    "App Settings",
                    theme,
                    IconButton(
                      onPressed: () {
                        AppNavigator.push(context, SettingPages());
                      },
                      icon: Icon(Icons.navigate_next, size: 20),
                    ),
                    () {},
                  ),
                  BasicHeadline(text: "Account"),

                  _settingBtn(
                    Icons.lock_open_outlined,
                    "Change account name",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next, size: 20),
                    ),
                    () {},
                  ),
                  _settingBtn(
                    Icons.key,
                    "Change account password",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                    () {},
                  ),
                  _settingBtn(
                    Icons.camera_alt_outlined,
                    "Change account image",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                    () {},
                  ),
                  BasicHeadline(text: "Uptodo"),
                  _settingBtn(
                    Icons.dataset_linked_outlined,
                    "About US",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                    () {},
                  ),
                  _settingBtn(
                    Icons.info_outline,
                    "FAQ",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                    () {},
                  ),
                  _settingBtn(
                    Icons.electric_bolt_rounded,
                    "Help & Feedback",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                    () {},
                  ),
                  _settingBtn(
                    Icons.thumb_up_alt_outlined,
                    "Support US",
                    theme,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_outlined, size: 20),
                    ),
                    () {},
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      children: [
                        const Icon(Icons.dark_mode_outlined, size: 22),
                        const SizedBox(width: 4),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          activeColor: theme.primaryColor,
                          value: themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            notifier.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  _settingBtn(Icons.logout, "Logout", theme, null, () async {
                    try {
                      await sl<SignOutUseCase>().call();
                      AppNavigator.pushAndRemove(context, SigninPage());
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }),
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
}
