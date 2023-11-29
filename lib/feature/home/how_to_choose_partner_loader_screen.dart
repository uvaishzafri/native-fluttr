import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/theme/theme.dart';
import 'package:native/util/color_utils.dart';

@RoutePage()
class HowToChoosePartnerLoaderScreen extends StatelessWidget {
  const HowToChoosePartnerLoaderScreen({super.key});

  _updateSystemUi(BuildContext context) {
    updateSystemUi(context, Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.primaryContainer);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAnalytics.instance.logTutorialBegin(
          parameters: Map.of({'name': 'tutorial_choose_partner'}));
      Future.delayed(const Duration(seconds: 3), () async {
        context.router.pop();
        context.router
            .push(const ChoosePartnerRoute())
            .then((value) => _updateSystemUi(context));
      });
    });
    _updateSystemUi(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorUtils.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              Image.asset('assets/ic_logo_light.png'),
              const SizedBox(height: 80),
              const Icon(
                CupertinoIcons.heart_fill,
                color: ColorUtils.purple,
                size: 37,
              ),
              // SvgPicture.asset(
              //   'assets/native_card/heart.svg',
              //   // colorFilter: const ColorFilter.mode(ColorUtils.purple, BlendMode.color),
              // ),
              const SizedBox(height: 10),
              SvgPicture.asset(
                'assets/neighbours.svg',
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "Let's learn how to choose your partner and get matched with a ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorUtils.textGrey,
                        height: 30 / 16,
                      ),
                  children: [
                    TextSpan(
                      text: 'LIKE',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: ColorUtils.purple,
                            height: 30 / 16,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // GradientCircularProgressIndicator(progress: progress, gradient: gradient),
              const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    ));
  }
}
