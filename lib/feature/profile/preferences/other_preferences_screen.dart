import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/profile/cubit/profile_cubit.dart';
import 'package:native/model/looking_for.dart';
import 'package:native/model/user_prefs.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_linear_progress_indicator.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';

@RoutePage()
class OtherPreferencesScreen extends StatefulWidget {
  const OtherPreferencesScreen({super.key, required this.gender, required this.minMaxAge, required this.location});
  final Gender gender;
  final RangeValues minMaxAge;
  final String location;

  @override
  State<OtherPreferencesScreen> createState() => _OtherPreferencesScreenState();
}

class _OtherPreferencesScreenState extends State<OtherPreferencesScreen> {
  String? selectedReligion;
  String? selectedCommunity;
  final TextEditingController religionSearchController = TextEditingController();
  final TextEditingController communitySearchController = TextEditingController();

  @override
  void dispose() {
    religionSearchController.dispose();
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
            middle: NativeMediumTitleText('What are you looking for?'),
          ),
          const SizedBox(height: 8),
          NativeLinearProgressIndicator(
            progress: 1 / 2,
            gradient: ColorUtils.nativeGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 4),
          Center(
            child: const NativeSmallBodyText(
              '1/2 done',
              color: ColorUtils.purple,
            ),
          ),
          const SizedBox(height: 20),
          const NativeSmallBodyText('Religion'),
          const SizedBox(height: 8),
          NativeDropdown(
              onChanged: (value) {
                setState(() {
                  selectedReligion = value;
                  // selectedCommunity = null;
                });
              },
              value: selectedReligion,
              searchController: religionSearchController,
              items: religions.keys
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: NativeMediumBodyText(item),
                      ))
                  .toList()),
          const SizedBox(height: 24),
          const NativeSmallBodyText('Community'),
          const SizedBox(height: 8),
          NativeDropdown(
              onChanged: (value) {
                setState(() {
                  selectedCommunity = value;
                });
              },
              value: selectedCommunity,
              searchController: communitySearchController,
            items: languages
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: NativeMediumBodyText(item),
                          ))
                .toList(),
          ),
          const Spacer(),
          NativeButton(
            isEnabled: profileCubit.validateOtherDetails(selectedReligion, selectedCommunity),
            text: 'Next',
            onPressed: () {
              final userPrefs = UserPrefs(
                  lookingFor: LookingFor(
                gender: widget.gender,
                location: widget.location,
                minAge: widget.minMaxAge.start,
                maxAge: widget.minMaxAge.end,
                community: selectedCommunity,
                religion: selectedReligion,
              ));
              profileCubit.updateUserPrefrences(userPrefs);
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.exception.message)));
                },
                profileUpdated: (_) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  context.router.push(const GenerateNativeCardRoute());
                },
                photoUpdated: (_) {},
                otherDetailsUpdated: (value) {},
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
}
