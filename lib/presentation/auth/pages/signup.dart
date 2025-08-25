import 'package:flutter/material.dart';
import 'package:mytodoapp/presentation/auth/pages/signin.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/textfield/basicTextfield.dart';
import '../../../common/widgets/button/basic_elevated_btn.dart';
import '../../../common/widgets/button/basic_react_btn.dart';
import '../../../core/config/assets/app_vectors.dart';
import '../../../core/config/theme/app_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          icon: Icons.navigate_before,
          title: null,
          onLeadingTap: () {
            AppNavigator.pop(context);
          },
          suffer: null,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            BasicTextField(controller: email, label: "UserName"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            BasicTextField(controller: password, label: "Password"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            BasicTextField(controller: password, label: "Confirm Password"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            BasicReactBtn(label: "Register", onPress: () {}, onSuccess: () {}),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text("or"),
                ),
                Expanded(child: Divider(thickness: 1, color: Colors.grey)),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            BasicElevatedBtn(
              label: "Continue with Google",
              onPress: () {},
              image: AssetImage(AppVectors.google),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            BasicElevatedBtn(
              label: "Continue with Facebook",
              onPress: () {},
              image: AssetImage(AppVectors.facebook),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 14, color: theme.colorScheme.onPrimary),
                ),
                TextButton(
                  onPressed: () {
                    AppNavigator.push(context, SigninPage());
                  },
                  child: Text("Login", style: TextStyle(color: AppColors.primary)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
