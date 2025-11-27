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
import '../bloc/splash_cubit.dart';
import '../bloc/splash_state.dart';

class IsFirstTimePage extends StatelessWidget {
  const IsFirstTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) async {
          if (state is Authenticated) {
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
