import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _assetFolder = "assets/onboarding";

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  final Logger logger = getIt<Logger>();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final List<Onboarding> _screens = <Onboarding>[
    Onboarding(
      img: "$_assetFolder/ill_profile.png",
      title: "Welcome to native.",
      desc:
          "Creating your unique native profile is effortless – just enter your date of birth, and voila! Your profile is instantly generated.",
    ),
    Onboarding(
      img: "$_assetFolder/ill_native.png",
      title: "Get your native. score",
      desc:
          "The native score is the indicator of your energy. Understanding your energy is the key to discovering what you truly seek in a partner.",
    ),
    Onboarding(
      img: "$_assetFolder/ill_match.png",
      title: "Find your match",
      desc:
          "Think of your native. card as a compass guiding you to someone who aligns with your authentic self. Discover connections that are meant to last.",
    ),
  ];

  OnboardingScreen({super.key});

  _storeOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skippedOnBoarding', true);
    logger.d(prefs.getBool('skippedOnBoarding'));
  }

  _navigateToSignIn(BuildContext context) {
    _storeOnboardInfo();
    context.router.replace(SignInRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              _navigateToSignIn(context);
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: _currentIndex == _screens.length - 1
                    ? Colors.transparent
                    : const Color(0xff1E1E1E),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: PageView.builder(
          itemCount: _screens.length,
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            _currentIndex = index;
          },
          itemBuilder: (_, pageIndex) => Container(
              padding: const EdgeInsets.all(0.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("$_assetFolder/bg_onboarding.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 261,
                          height: 200,
                          child: Image.asset(
                            _screens[pageIndex].img,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(_screens[pageIndex].title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xff7bc6cc),
                                fontSize: 16,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Text(_screens[pageIndex].desc,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff595959),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 36.0),
                        height: 56.0,
                        child: ListView.builder(
                          itemCount: _screens.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: pageIndex == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pageIndex < (_screens.length - 1)
                              ? _pageController.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.linear)
                              : _navigateToSignIn(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 26.0, vertical: 14.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff7bc6cc),
                            size: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
