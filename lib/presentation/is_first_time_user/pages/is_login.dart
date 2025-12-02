import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/core/config/assets/app_images.dart';
import 'package:mytodoapp/presentation/auth/pages/onboarding.dart';
import 'package:mytodoapp/presentation/auth/pages/signin.dart';
import 'package:mytodoapp/presentation/index/pages/index_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../service_locator.dart';
import '../bloc/is_login_cubit.dart';
import '../bloc/is_login_state.dart';

class IsLoginPage extends StatelessWidget {
  const IsLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IsLoginCubit, IsLoginState>(
        listener: (context, state) async {
          if(state is FirstTimeUser){
            AppNavigator.pushAndRemove(context, OnboardingPage());
          } else if (state is Authenticated) {
            AppNavigator.pushAndRemove(context, IndexPage());
          } else {
            AppNavigator.pushAndRemove(context, SigninPage());
          }
        },
        child: Center(
          child: SizedBox(
            height: 90,
            width: 90,
            child: CircularProgressIndicator()
          ),
        ),
      ),
    );
  }
}
