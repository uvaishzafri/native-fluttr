import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/images.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_card.dart';
import 'package:native/widget/native_simple_button.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class NativeCardDetailsScreen extends StatefulWidget {
  const NativeCardDetailsScreen({super.key, required this.nativeCard});

  final NativeCard? nativeCard;

  @override
  State<NativeCardDetailsScreen> createState() => _NativeCardDetailsScreenState();
}

class _NativeCardDetailsScreenState extends State<NativeCardDetailsScreen> {
  NativeCard? nativeUser;
  User? user;
  // NativeCard? nativeUser;

  @override
  void initState() {
    super.initState();
    nativeUser = widget.nativeCard;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initUser();
      setState(() {});
    });
  }

  void initUser() async {
    var prefs = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(prefs.getString('user')!));
    if (widget.nativeCard != null) {
      nativeUser = widget.nativeCard;
    } else {

    UserRepository userRepository = getIt<UserRepository>();
    var response = await userRepository.getCurrentUserNativeCardDetails();
    if (response.isRight) {
        nativeUser = response.right;
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: ColorUtils.nativeGradient,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset("assets/ic_logo_dark.png"),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorUtils.white,
                            ),
                            child: BigNativeUserCard(
                              native: nativeUser!,
                              user: user!,
                              // userImage: Image.asset("assets/home/ic_test.png"),
                            ),
                          ),
                          const SizedBox(height: 10),
                          needsParameterCard(),
                          const SizedBox(height: 10),
                          celebsCard(),
                          const SizedBox(height: 10),
                          personalityCard(),
                          const SizedBox(height: 10),
                          loveCard(),
                          const SizedBox(height: 10),
                          idealPartnerCard(),
                          const SizedBox(height: 10),
                          adviceCard(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 8),
                  // NativeSimpleButton(
                  //   isEnabled: true,
                  //   text: 'Next',
                  //   onPressed: () => context.router.push(const HowToChoosePartnerLoaderRoute()),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget needsParameterCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          cardHeader('assets/native_card/man.svg', 'Needs parameter'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 25,
            runSpacing: 40,
            children: [
              needsParameterItem('assets/native_card/payments.svg', 10, 'Financial'),
              needsParameterItem('assets/native_card/paintbrush.svg', 10, 'Expression'),
              needsParameterItem('assets/native_card/neurology.svg', 30, 'Curiosity'),
              needsParameterItem('assets/native_card/accessibility.svg', 40, 'Independence'),
              needsParameterItem('assets/native_card/running.svg', 10, 'Activity'),
            ],
          ),
        ],
      ),
    );
  }

  Widget celebsCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          cardHeader('assets/native_card/community.svg', 'Celebs with same personality traits'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  NativeHeadImage(
                    Image.asset("assets/native_card/ariana.png"),
                    borderColor: ColorUtils.aquaGreen,
                    radius: 29,
                    borderRadius: 1,
                    isGradientBorder: false,
                  ),
                  const NativeMediumBodyText(
                    'Ariana',
                    letterSpacing: 2.8,
                  )
                ],
              ),
              Column(
                children: [
                  NativeHeadImage(
                    Image.asset("assets/native_card/adele.png"),
                    borderColor: ColorUtils.aquaGreen,
                    radius: 29,
                    borderRadius: 1,
                    isGradientBorder: false,
                  ),
                  const NativeMediumBodyText(
                    'Adele',
                    letterSpacing: 2.8,
                  )
                ],
              ),
              Column(
                children: [
                  NativeHeadImage(
                    Image.asset("assets/native_card/zendaya.png"),
                    borderColor: ColorUtils.aquaGreen,
                    radius: 29,
                    borderRadius: 1,
                    isGradientBorder: false,
                  ),
                  const NativeMediumBodyText(
                    'Zendaya',
                    letterSpacing: 2.8,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget personalityCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardHeader('assets/native_card/group.svg', 'Personality'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          personalityItems('Leadership', 'Resilient and spirited for challenges'),
          personalityItems('Adventurous', 'Willing to try out new experiences'),
          personalityItems('Caring', 'Devoted and kind hearted'),
          personalityItems('Ambitious', 'Strong desire to achieve set gols'),
        ],
      ),
    );
  }

  Widget loveCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          cardHeader('assets/native_card/heart.svg', 'Love'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          const NativeMediumBodyText(
            'Gets bored easily and seeks simulation due to being versatile but lacking constancy',
            height: 24 / 14,
          ),
          const SizedBox(height: 20),
          const NativeMediumBodyText(
            'Can meet the trust and expectations from others',
            height: 24 / 14,
          ),
          const SizedBox(height: 20),
          const NativeMediumBodyText(
            'Seen as assertive because of speaking their mind cleraly',
            height: 24 / 14,
          ),
        ],
      ),
    );
  }

  Widget idealPartnerCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardHeader('assets/native_card/couple_with_heart.svg', 'Ideal Partner'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          Wrap(
            // alignment: WrapAlignment.spaceEvenly,
            spacing: 10,
            runSpacing: 25,
            children: [
              idealPartnerChip(svgAssetPath: 'assets/native_card/child_care.svg', text: 'Child care', chipColor: ColorUtils.purple),
              idealPartnerChip(svgAssetPath: 'assets/native_card/laptop.svg', text: 'UI/UX Designer', chipColor: ColorUtils.aquaGreen),
              idealPartnerChip(svgAssetPath: 'assets/native_card/support.svg', text: 'Customer support', chipColor: ColorUtils.lightBlue),
            ],
          ),
          const SizedBox(height: 20),
          const NativeMediumBodyText('Provides a sense of Security and is trustworthy'),
          const SizedBox(height: 20),
          const NativeMediumBodyText('Possess strong leadership'),
          const SizedBox(height: 20),
          const NativeMediumBodyText('Can grow and enjoy changes together'),
        ],
      ),
    );
  }

  Widget adviceCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          cardHeader('assets/native_card/hand_with_heart.svg', 'Advice'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          const NativeMediumBodyText(
            'Take others view point and not assert your own opinions',
            height: 24 / 14,
          ),
          const SizedBox(height: 20),
          const NativeMediumBodyText(
            'Continuously work on improving yourself and provide fresh appeal to your partner ',
            height: 24 / 14,
          ),
          const SizedBox(height: 20),
          const NativeMediumBodyText(
            'Value communication with your partner and cherish the relationship',
            height: 24 / 14,
          ),
        ],
      ),
    );
  }

  Widget personalityItems(String header, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NativeSmallTitleText(header),
          const SizedBox(height: 10),
          NativeMediumBodyText(body),
        ],
      ),
    );
  }

  Widget cardHeader(String assetPath, String title) {
    return Row(
      children: [
        SvgPicture.asset(assetPath),
        const SizedBox(width: 10),
        NativeMediumTitleText(
          title,
          color: ColorUtils.purple,
          height: 22 / 16,
        )
      ],
    );
  }

  Widget needsParameterItem(String svgAssetPath, int value, String title) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(svgAssetPath),
            const SizedBox(width: 4),
            NativeMediumTitleText('$value%', fontSize: 28),
          ],
        ),
        NativeMediumTitleText(title),
      ],
    );
  }

  Widget idealPartnerChip({required String svgAssetPath, required String text, Color? chipColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: chipColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(svgAssetPath),
          const SizedBox(width: 10),
          NativeSmallBodyText(
            text,
            fontSize: 10,
            color: ColorUtils.white,
            height: 14 / 10,
          )
        ],
      ),
    );
  }
}
