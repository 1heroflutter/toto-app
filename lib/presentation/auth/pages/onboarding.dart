import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';
import 'package:mytodoapp/presentation/auth/pages/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/assets/app_images.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../service_locator.dart';

Future<void> setOnboardingCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasCompletedOnboarding', true);
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> images = [
      AppImages.onBoarding1,
      AppImages.onBoarding2,
      AppImages.onBoarding3,
    ];
    final List<String> title = [
      "Manage your tasks",
      "Create daily routine",
      "Organaize your tasks",
    ];
    final List<String> title2 = [
      "You can easily manage all of your daily tasks in ToDo for free.",
      "In ToDo  you can create your personalized routine to stay productive.",
      "You can organize your daily tasks by adding your tasks into separate categories.",
    ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: null,
              controller: pageController,
              onPageChanged:
                  (value) => setState(() {
                    currentPage = value;
                  }),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: double.infinity,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title[index],
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              title2[index],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      currentPage == 0
                                          ? theme.primaryColor
                                          : Colors.grey,
                                ),
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 4),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      currentPage == 1
                                          ? theme.primaryColor
                                          : Colors.grey,
                                ),
                                height: 15,
                                width: 15,
                              ),
                              SizedBox(width: 4),

                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      currentPage == 2
                                          ? theme.primaryColor
                                          : Colors.grey,
                                ),
                                height: 15,
                                width: 15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if (currentPage != 0)
                                TextButton(
                                  onPressed: () {
                                    pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Text(
                                    "Back",
                                    style: TextStyle(color: theme.primaryColor),
                                  ),
                                ),
                              ElevatedButton(
                                onPressed: () {
                                  if (currentPage == images.length - 1) {
                                    setOnboardingCompleted();
                                    sl<AuthRepository>().setFirstTimeFinished();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SigninPage(),
                                      ),
                                    );
                                  } else {
                                    pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    theme.primaryColor,
                                  ),
                                ),
                                child: Text(
                                  currentPage == images.length - 1
                                      ? "Get Started"
                                      : "Next",
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
