import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytodoapp/common/bloc/generic_data_cubit.dart';
import 'package:mytodoapp/common/helper/app_navigator.dart';
import 'package:mytodoapp/common/widgets/appbar/basic_appbar.dart';
import 'package:mytodoapp/common/widgets/textfield/basic_text_field.dart';
import 'package:mytodoapp/common/widgets/button/basic_elevated_btn.dart';
import 'package:mytodoapp/common/widgets/button/basic_react_btn.dart';
import 'package:mytodoapp/core/config/assets/app_vectors.dart';
import 'package:mytodoapp/data/auth/models/user.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';
import 'package:mytodoapp/domain/auth/usecase/signin.dart';
import 'package:mytodoapp/domain/auth/usecase/signin_with_google.dart';
import 'package:mytodoapp/presentation/auth/pages/signup.dart';
import 'package:mytodoapp/presentation/index/pages/index_page.dart';
import 'package:reactive_button/reactive_button.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../service_locator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _idLoading = false;
  String? _passwordError;
  String? _usernameError;

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
          title: null,
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
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                BasicTextField(
                  controller: email,
                  label: "Email",
                  errorText: _usernameError,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                BasicTextField(
                  controller: password,
                  label: "Password",
                  errorText: _passwordError,
                  obscureText: true,

                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                BasicReactBtn(
                  label: "SignIn",
                  onPress: () async {
                    setState(() {
                      _passwordError = null;
                      _usernameError = null;
                    });
                    if (email.text.isEmpty) {
                      setState(() {
                        _usernameError = "Email cannot be blank";
                      });
                    }
                    if (password.text.length < 6) {
                      setState(() {
                        _passwordError = "Password must be 6 characters or more";
                      });
                    }
                    return await sl<SignInUseCase>().call(
                      params: UserEntity(
                        email: email.text,
                        password: password.text,
                      ),
                    );
                  },
                  onSuccess: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          " Login success",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    AppNavigator.pushAndRemove(context, IndexPage());
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              " Login success",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
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
                      'Don’t have an account ?',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        AppNavigator.push(context, SignupPage());
                      },
                      child: Text(
                        "Register",
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
