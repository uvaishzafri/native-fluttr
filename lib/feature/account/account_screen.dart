import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, required this.imageUrl, required this.displayName});
  final String imageUrl;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        GestureDetector(
          onTap: () => context.router.push(const EditProfileRoute()),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              'Edit Profile',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorUtils.purple, decoration: TextDecoration.underline),
            ),
          ),
        ),
        Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.grey,
              image: DecorationImage(image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover)),
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
                onTap: () => context.router.push(const NotificationSettingsRoute()),
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
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: NativeLargeBodyText('Feedback'),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
                onTap: () {},
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
