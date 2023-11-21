import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:native/config.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/model/user.dart';
import 'package:native/theme/theme.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/launcher.dart';
import 'package:native/widget/common_scaffold.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AccountScreen extends StatefulWidget {
  const AccountScreen(
      {super.key /*, required this.imageUrl, required this.displayName*/});
  // final String imageUrl;
  // final String displayName;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutoRouteAwareStateMixin<AccountScreen> {
  late String imageUrl;
  late String displayName;

  final InAppReview _inAppReview = InAppReview.instance;
  final Config _config = getIt<Config>();

  @override
  void initState() {
    super.initState();
    imageUrl = '';
    displayName = '';
    refreshUserDetails();
    CommonScaffold.commonScaffoldUpdateSystemUi(context);
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    CommonScaffold.commonScaffoldUpdateSystemUi(context);
  }

  void refreshUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final user = User.fromJson(jsonDecode(userJson));
      if (user.photoURL?.isNotEmpty ?? false) {
        imageUrl = user.photoURL!;
      }
      if (user.displayName?.isNotEmpty ?? false) {
        displayName = user.displayName!;
      }
      if (context.mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonScaffold.commonScaffoldUpdateSystemUi(context);
    Widget content = Column(
      children: [
        GestureDetector(
          onTap: () async {
            await context.router.push(const EditProfileRoute());
            refreshUserDetails();
          },
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: ColorUtils.purple,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),
        Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.grey,
              image: imageUrl.isEmpty
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(imageUrl),
                      fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NativeSmallTitleText(displayName),
        ),
        const Spacer(),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    context.router.push(const NotificationSettingsRoute()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: NativeLargeBodyText('Notification settings'),
                ),
              ),
              GestureDetector(
                onTap: () => context.router.push(const AccountPlansRoute()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: NativeLargeBodyText('Account plan'),
                ),
              ),
              // GestureDetector(
              //   onTap: () => context.router.push(const SocialAccountSettingsRoute()),
              //   child: const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 12.0),
              //     child: NativeLargeBodyText('Social accounts'),
              //   ),
              // ),
              GestureDetector(
                onTap: () async {
                  if (await _inAppReview.isAvailable()) {
                    _inAppReview.requestReview();
                  }
                  FirebaseAnalytics.instance.logEvent(
                    name: 'clicked_user_feedback',
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: NativeLargeBodyText('Feedback'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launcher(Uri.parse(_config.nativePricingUrl));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      NativeLargeBodyText('Pricing'),
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 16,
                        color: ColorUtils.purple,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launcher(Uri.parse(_config.termsAndConditionsUrl));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      NativeLargeBodyText('Terms & Conditions'),
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 16,
                        color: ColorUtils.purple,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launcher(Uri.parse(_config.privacyPolicyUrl));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      NativeLargeBodyText('Privacy Policy'),
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 16,
                        color: ColorUtils.purple,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // FirebaseAuth.instance.signOut();
                  context.read<AppCubit>().logout();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: NativeLargeBodyText('Sign out'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
    return CommonScaffoldWithPadding('Account', content);
  }
}
