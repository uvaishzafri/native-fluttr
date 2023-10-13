import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/util/color_utils.dart';

@RoutePage()
class HowToChoosePartnerLoaderScreen extends StatelessWidget {
  const HowToChoosePartnerLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        context.router.pop();
        context.router.push(const ChoosePartnerRoute());
      });
    });
    return Scaffold(
      backgroundColor: ColorUtils.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              Image.asset('assets/ic_logo_light.png'),
              const SizedBox(height: 80),
              Icon(
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
                  text: "Let's learn how to choose your partner and get matched with a ",
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
    );
  }
}
