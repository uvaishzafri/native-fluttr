import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/profile/cubit/profile_cubit.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/user.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_linear_progress_indicator.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';

@RoutePage()
class OtherDetailsScreen extends StatefulWidget {
  const OtherDetailsScreen({super.key});

  @override
  State<OtherDetailsScreen> createState() => _OtherDetailsScreenState();
}

class _OtherDetailsScreenState extends State<OtherDetailsScreen> {
  List<String>? selectedReligion;
  List<String>? selectedCommunity;
  final TextEditingController religionSearchController =
      TextEditingController();
  final TextEditingController communitySearchController =
      TextEditingController();

  @override
  void dispose() {
    religionSearchController.dispose();
    communitySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget otherDetails(ProfileCubit profileCubit) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const CupertinoNavigationBar(
            border: Border(),
            backgroundColor: Colors.transparent,
            middle: NativeMediumTitleText('Create your profile'),
          ),
          const SizedBox(height: 8),
          NativeLinearProgressIndicator(
            progress: 2 / 3,
            gradient: ColorUtils.nativeGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 4),
          const Center(
            child: NativeSmallBodyText(
              '2/3 done',
              color: ColorUtils.purple,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              NativeSmallBodyText('Religion'),
              NativeSmallBodyText('(maximum select items: 3)', fontSize: 10),
            ],
          ),
          const SizedBox(height: 8),
          NativeDropdown(
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  selectedReligion = value;
                });
              } else {
                setState(() {
                  selectedReligion = null;
                });
              }
            },
            searchController: religionSearchController,
            maxItems: 3,
            textStyle: NativeMediumBodyText.getStyle(context),
            items: religions.keys
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: NativeMediumBodyText(item),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              NativeSmallBodyText('Language'),
              NativeSmallBodyText('(maximum select items: 3)', fontSize: 10),
            ],
          ),
          const SizedBox(height: 8),
          NativeDropdown(
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  selectedCommunity = value;
                });
              } else {
                setState(() {
                  selectedCommunity = null;
                });
              }
            },
            searchController: communitySearchController,
            maxItems: 3,
            textStyle: NativeMediumBodyText.getStyle(context),
            items: languages
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: NativeMediumBodyText(item),
                    ))
                .toList(),
          ),
          const Spacer(),
          NativeButton(
            isEnabled: true,
            // profileCubit.validateOtherDetails(
            //   selectedReligion,
            //   selectedCommunity,
            // ),
            text: 'Next',
            onPressed: () {
              final user = User(
                customClaims: CustomClaims(
                  religion: selectedReligion,
                  community: selectedCommunity,
                ),
              );
              profileCubit.updateOtherDetails(user);
              // context.router.replaceAll([
              //   const BasicPrefrencesRoute()
              // ]);
            },
          ),
          const SizedBox(height: 40),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: BlocProvider<ProfileCubit>.value(
          value: getIt<ProfileCubit>(),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              state.map(
                initial: (_) {},
                loading: (value) {
                  if (!context.loaderOverlay.visible) {
                    context.loaderOverlay.show();
                  }
                },
                userDetails: (_) {
                  // if (context.loaderOverlay.visible) {
                  //   context.loaderOverlay.hide();
                  // }
                  // context.router.push(PhotoUploadRoute(gender: _selectedGender));
                },
                error: (value) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  if (value.exception is UnauthorizedException) {
                    BlocProvider.of<AppCubit>(context).logout();
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value.exception.message),
                  ));
                },
                profileUpdated: (_) {},
                photoUpdated: (_) {},
                otherDetailsUpdated: (_) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 3), () {
                        // context.router.pop();
                        if (context.mounted) {
                          Navigator.pop(context);
                          context.router
                              .replaceAll([const BasicPrefrencesRoute()]);
                        }
                      });
                      return _profileSuccessfullyCreatedDialog();
                    },
                  );
                },
              );
            },
            builder: (context, state) {
              final profileCubit = BlocProvider.of<ProfileCubit>(context);
              return Container(
                margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
                child: otherDetails(profileCubit),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _profileSuccessfullyCreatedDialog() {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/profile/ic_women_with_balloons.svg"),
                const SizedBox(height: 28),
                const Text(
                  "Profile successfully created!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
