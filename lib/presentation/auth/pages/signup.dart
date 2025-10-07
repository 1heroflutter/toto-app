import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytodoapp/data/auth/models/user.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';
import 'package:mytodoapp/domain/auth/usecase/signup.dart';
import 'package:mytodoapp/presentation/auth/pages/signin.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/textfield/basic_text_field.dart';
import '../../../common/widgets/button/basic_elevated_btn.dart';
import '../../../common/widgets/button/basic_react_btn.dart';
import '../../../core/config/assets/app_vectors.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../domain/auth/usecase/signin_with_google.dart';
import '../../../service_locator.dart';
import '../../index/pages/index_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String? _passwordError;
  String? _confirmPasswordError;
  bool _idLoading = false;

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
      body: Stack(
        children: [
          Padding(
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
                BasicTextField(controller: email, label: "Email"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                BasicTextField(
                  controller: password,
                  label: "Password",
                  errorText: _passwordError,
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                BasicTextField(
                  controller: confirmPassword,
                  label: "Confirm Password",
                  errorText: _confirmPasswordError,
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                BasicReactBtn(
                  label: "Register",
                  onPress: () async {
                    setState(() {
                      _passwordError = null;
                      _confirmPasswordError = null;
                    });

                    if (password.text != confirmPassword.text) {
                      setState(() {
                        _confirmPasswordError = "Mật khẩu không khớp";
                      });
                    }

                    if (password.text.length < 6) {
                      setState(() {
                        _passwordError = "Mật khẩu phải từ 6 ký tự trở lên";
                      });
                    }

                    // gọi usecase
                    return await sl<SignUpUseCase>().call(
                      params: UserEntity(
                        email: email.text,
                        password: password.text,
                      ),
                    );
                  },
                  onSuccess: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Đăng ký thành công!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    AppNavigator.push(context, SigninPage());
                  },
                ),

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
                  onPress: () async {
                    setState(() {
                      _idLoading = true;
                    });
                    //Mở và chọn tài khoản gg
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signIn();
                    if (googleUser == null) ;
                    //lấy token xác thực
                    final GoogleSignInAuthentication googleAuth =
                        await googleUser!.authentication;
                    //tạo credential cho firebase
                    final credential = GoogleAuthProvider.credential(
                      idToken: googleAuth.idToken,
                      accessToken: googleAuth.accessToken,
                    );
                    final signin = await sl<SignInWithGoogleUseCase>().call(
                      params: credential,
                    );
                    return signin.fold(
                      (failure) => print("❌ Error: $failure"),
                      (user) {
                        print("✅ Login success: ${user.displayName}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Đăng nhập thành công",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        AppNavigator.pushAndRemove(context, IndexPage());
                      },
                    );
                  },
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
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        AppNavigator.push(context, SigninPage());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_idLoading) ...{
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              width: double.infinity,
              height: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            ),
          },
        ],
      ),
    );
  }
}
