import 'dart:convert';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/di/di.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/widget/images.dart';
import 'package:native/widget/native_card.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class NativeCardDetailsScreen extends StatefulWidget {
  const NativeCardDetailsScreen({super.key, required this.user, this.isDemoUser = false, this.showBackButton = false});

  final User user;
  final bool isDemoUser;
  final bool showBackButton;

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
    // nativeUser = widget.nativeCard;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initUser();
      setState(() {});
    });
  }

  Future initUser() async {
    user = widget.user;
    if (widget.isDemoUser) {
      nativeUser = usersList2[0];
      // user = usersList[0];
    } else {
      // var prefs = await SharedPreferences.getInstance();
      // user = User.fromJson(jsonDecode(prefs.getString('user')!));
      UserRepository userRepository = getIt<UserRepository>();
      var response = await userRepository.getUserNativeCardDetails(userId: widget.user.uid!);
      if (response.isRight) {
        nativeUser = response.right;
        final prefs = await SharedPreferences.getInstance();
        String? userJson = prefs.getString('user');
        if (userJson != null) {
          User user = User.fromJson(jsonDecode(userJson));
          if (user.uid == widget.user.uid) {
            user = user.copyWith(native: nativeUser!.meta);
            prefs.setString('user', jsonEncode(user.toJson()));
          }
        }
      } else {
        if (response.left is UnauthorizedException) {
          if (context.mounted) {
            BlocProvider.of<AppCubit>(context).logout();
          }
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: widget.showBackButton ? AppBar() : null,
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
                                idealDatePlanCard(),
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
              needsParameterItem('assets/native_card/payments.svg',
                  ((nativeUser?.meta?.parameter?.finance ?? 0) * 100).toInt(), 'Financial'),
              needsParameterItem('assets/native_card/paintbrush.svg',
                  ((nativeUser?.meta?.parameter?.fun ?? 0) * 100).toInt(), 'Expression'),
              needsParameterItem('assets/native_card/neurology.svg',
                  ((nativeUser?.meta?.parameter?.knowledge ?? 0) * 100).toInt(), 'Curiosity'),
              needsParameterItem('assets/native_card/accessibility.svg',
                  ((nativeUser?.meta?.parameter?.independence ?? 0) * 100).toInt(), 'Independence'),
              needsParameterItem('assets/native_card/running.svg',
                  ((nativeUser?.meta?.parameter?.active ?? 0) * 100).toInt(), 'Activity'),
            ],
          ),
        ],
      ),
    );
  }

  Widget celebsCard() {
    final celebList = nativeUser!.personality!.sameKindCelebrity!.split(", ");
    if (celebList.length > 3) {
      celebList.removeRange(3, celebList.length);
    }
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          cardHeader('assets/native_card/community.svg', 'Celebs with same personality'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: celebList
                .map(
                  (e) => SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        NativeHeadImage(
                          Image.asset("assets/native_card/ariana.png"),
                          borderColor: ColorUtils.aquaGreen,
                          radius: 29,
                          borderRadius: 1,
                          isGradientBorder: false,
                        ),
                        SizedBox(height: 4),
                        NativeMediumBodyText(
                          e,
                          textAlign: TextAlign.center,
                          letterSpacing: 2.8,
                        )
                      ],
                    ),
                  ),
                )
                .toList(),

            // [
            //   Column(
            //     children: [

            //       NativeHeadImage(
            //         Image.asset("assets/native_card/ariana.png"),
            //         borderColor: ColorUtils.aquaGreen,
            //         radius: 29,
            //         borderRadius: 1,
            //         isGradientBorder: false,
            //       ),
            //       const NativeMediumBodyText(
            //         'Ariana',
            //         letterSpacing: 2.8,
            //       )
            //     ],
            //   ),
            //   Column(
            //     children: [
            //       NativeHeadImage(
            //         Image.asset("assets/native_card/adele.png"),
            //         borderColor: ColorUtils.aquaGreen,
            //         radius: 29,
            //         borderRadius: 1,
            //         isGradientBorder: false,
            //       ),
            //       const NativeMediumBodyText(
            //         'Adele',
            //         letterSpacing: 2.8,
            //       )
            //     ],
            //   ),
            //   Column(
            //     children: [
            //       NativeHeadImage(
            //         Image.asset("assets/native_card/zendaya.png"),
            //         borderColor: ColorUtils.aquaGreen,
            //         radius: 29,
            //         borderRadius: 1,
            //         isGradientBorder: false,
            //       ),
            //       const NativeMediumBodyText(
            //         'Zendaya',
            //         letterSpacing: 2.8,
            //       )
            //     ],
            //   ),
            // ],
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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: nativeUser!.personality!.hashTags!
                .split("#")
                .where((element) => element.isNotEmpty)
                .map((ele) => idealPartnerChip(text: ele))
                .toList(),
          ),
          // NativeMediumTitleText(nativeUser!.personality!.hashTags!),
          const SizedBox(height: 12),
          ...nativeUser!.personality!.descriptions!.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: NativeMediumBodyText(e),
            ),
          ),
          // personalityItems('Leadership', 'Resilient and spirited for challenges'),
          // personalityItems('Adventurous', 'Willing to try out new experiences'),
          // personalityItems('Caring', 'Devoted and kind hearted'),
          // personalityItems('Ambitious', 'Strong desire to achieve set gols'),
        ],
      ),
    );
  }

  Widget loveCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardHeader('assets/native_card/heart.svg', 'Love'),
          const SizedBox(height: 12),
          const DottedLine(),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: nativeUser!.love!.hashTags!
                .split("#")
                .where((element) => element.isNotEmpty)
                .map((ele) => idealPartnerChip(text: ele))
                .toList(),
          ),
          // NativeMediumTitleText(nativeUser!.love!.hashTags!),
          ...nativeUser!.love!.descriptions!.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: NativeMediumBodyText(e),
            ),
          ),
          //   const SizedBox(height: 12),
          // const NativeMediumBodyText(
          //     'Gets bored easily and seeks simulation due to being versatile but lacking constancy',
          //     height: 24 / 14,
          //   ),
          //   const SizedBox(height: 20),
          //   const NativeMediumBodyText(
          //     'Can meet the trust and expectations from others',
          //     height: 24 / 14,
          //   ),
          //   const SizedBox(height: 20),
          //   const NativeMediumBodyText(
          //     'Seen as assertive because of speaking their mind cleraly',
          //     height: 24 / 14,
          //   ),
        ],
      ),
    );
  }

  Widget idealDatePlanCard() {
    return Container(
      decoration: BoxDecoration(color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardHeader('assets/native_card/couple_with_heart.svg', 'Ideal Date Plan'),
          const SizedBox(height: 12),
          const DottedLine(),
          ...nativeUser!.ideasPlan!.descriptions!.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 20),
              child: NativeMediumBodyText(e),
            ),
          ),
          // Wrap(
          //   // alignment: WrapAlignment.spaceEvenly,
          //   spacing: 10,
          //   runSpacing: 25,
          //   children: [
          //     idealPartnerChip(svgAssetPath: 'assets/native_card/child_care.svg', text: 'Child care', chipColor: ColorUtils.purple),
          //     idealPartnerChip(svgAssetPath: 'assets/native_card/laptop.svg', text: 'UI/UX Designer', chipColor: ColorUtils.aquaGreen),
          //     idealPartnerChip(svgAssetPath: 'assets/native_card/support.svg', text: 'Customer support', chipColor: ColorUtils.lightBlue),
          //   ],
          // ),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText('Provides a sense of Security and is trustworthy'),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText('Possess strong leadership'),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText('Can grow and enjoy changes together'),
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
          ...nativeUser!.partner!.descriptions!.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 20),
              child: NativeMediumBodyText(e),
            ),
          ),
          // const SizedBox(height: 20),
          // Wrap(
          //   // alignment: WrapAlignment.spaceEvenly,
          //   spacing: 10,
          //   runSpacing: 25,
          //   children: [
          //     idealPartnerChip(svgAssetPath: 'assets/native_card/child_care.svg', text: 'Child care', chipColor: ColorUtils.purple),
          //     idealPartnerChip(svgAssetPath: 'assets/native_card/laptop.svg', text: 'UI/UX Designer', chipColor: ColorUtils.aquaGreen),
          //     idealPartnerChip(svgAssetPath: 'assets/native_card/support.svg', text: 'Customer support', chipColor: ColorUtils.lightBlue),
          //   ],
          // ),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText('Provides a sense of Security and is trustworthy'),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText('Possess strong leadership'),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText('Can grow and enjoy changes together'),
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
          ...nativeUser!.advice!.descriptions!.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 20),
              child: NativeMediumBodyText(e),
            ),
          ),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText(
          //   'Take others view point and not assert your own opinions',
          //   height: 24 / 14,
          // ),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText(
          //   'Continuously work on improving yourself and provide fresh appeal to your partner ',
          //   height: 24 / 14,
          // ),
          // const SizedBox(height: 20),
          // const NativeMediumBodyText(
          //   'Value communication with your partner and cherish the relationship',
          //   height: 24 / 14,
          // ),
        ],
      ),
    );
  }

  // Widget personalityItems(String header, String body) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         NativeSmallTitleText(header),
  //         const SizedBox(height: 10),
  //         NativeMediumBodyText(body),
  //       ],
  //     ),
  //   );
  // }

  Widget cardHeader(String assetPath, String title, {Color? color}) {
    return Row(
      children: [
        SvgPicture.asset(
          assetPath,
          colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        ),
        const SizedBox(width: 10),
        NativeMediumTitleText(
          title,
          color: color,
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
            NativeMediumTitleText(
              '$value%',
              fontSize: 28,
              color: ColorUtils.purple,
            ),
          ],
        ),
        NativeMediumTitleText(title),
      ],
    );
  }

  Widget idealPartnerChip({required String text}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SvgPicture.asset(svgAssetPath),
          // const SizedBox(width: 10),
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
