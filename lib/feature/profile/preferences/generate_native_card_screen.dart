import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/profile/cubit/profile_cubit.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_simple_button.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

@RoutePage()
class GenerateNativeCardScreen extends StatefulWidget {
  const GenerateNativeCardScreen({super.key});

  @override
  State<GenerateNativeCardScreen> createState() => _GenerateNativeCardScreenState();
}

class _GenerateNativeCardScreenState extends State<GenerateNativeCardScreen> {
  DateTime _selectedDate = DateTime(2003, 6, 15);
  @override
  Widget build(BuildContext context) {
    Widget photoUpload(ProfileCubit profileCubit) {
      return Column(
        children: [
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const NativeLargeBodyText('Generate '),
              GradientText(
                'native.',
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                colors: const [
                  Color(0xFFBE94C6),
                  Color(0xFF7BC6CC),
                ],
              ),
              const NativeLargeBodyText(' card'),
            ],
          ),
          // const NativeLargeBodyText('Generate native. card'),
          const SizedBox(height: 42),
          SvgPicture.asset('assets/girl_with_balloons.svg'),
          const SizedBox(height: 42),
          const NativeMediumBodyText(
              'Enter your date of birth, we will generate your native card and help you find your match'),
          // const SizedBox(height: 42),
          const Spacer(),
          SizedBox(
              height: 200,
              child: DatePickerWidget(
                // firstDate: DateTime.now().subtract(Duration()),
                lastDate: DateTime.now(),
                initialDate: DateTime(2003, 6, 15),
                onChange: (dateTime, selectedIndex) {
                  setState(() {
                    _selectedDate = dateTime;
                  });
                },
                dateFormat: 'MMM/d/y',
                pickerTheme: DateTimePickerTheme(
                  dividerColor: ColorUtils.textLightGrey.withOpacity(0.5),
                  itemTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorUtils.purple),
                ),
              )),
          const Spacer(),
          NativeButton(
            isEnabled: true,
            text: 'Generate',
            onPressed: () {
              if (!isDateValid(_selectedDate)) {
                return ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Age should be greater than 18 and less than 50 yrs')));
              }
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => confirmationDialog(profileCubit),
              );
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
                profileUpdated: (_) async {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  context.router.pop();
                  var overlayItem = Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: NativeButton(
                      isEnabled: true,
                      text: 'Next',
                      onPressed: () => context.router.push(const HowToChoosePartnerLoaderRoute()),
                    ),
                  );
                  final prefs = await SharedPreferences.getInstance();
                  final userJson = prefs.getString('user');
                  if (userJson != null) {
                    if (context.mounted) {
                      var user = User.fromJson(jsonDecode(userJson));
                      context.router.push(NativeCardScaffold(user: user, overlayItem: overlayItem));
                    }
                  }
                },
                photoUpdated: (_) {},
                otherDetailsUpdated: (value) {},
              );
            },
            builder: (context, state) {
              final profileCubit = BlocProvider.of<ProfileCubit>(context);
              return Container(
                margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
                child: photoUpload(profileCubit),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget confirmationDialog(ProfileCubit profileCubit) {
    return AlertDialog(
      backgroundColor: ColorUtils.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you want to generate the native.card for this date?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorUtils.black.withOpacity(0.6),
            ),
          ),
          NativeMediumBodyText(
            'You will not be able to change this later.',
            color: ColorUtils.black.withOpacity(0.6),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: NativeSimpleButton(
                isEnabled: true,
                onPressed: () => context.router.pop(),
                fontSize: 14,
                text: 'Cancel',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: NativeButton(
                isEnabled: true,
                text: 'Yes, Generate',
                fontSize: 14,
                onPressed: () {
                  final user = User(
                    customClaims: CustomClaims(
                      birthday: DateFormat('yyyy-MM-dd').format(_selectedDate),
                      // birthday: _selectedDate!.toIso8601String(),
                    ),
                  );
                  profileCubit.updateProfile(user);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  bool isDateValid(DateTime date) {
    DateTime currentDate = DateTime.now();
    DateTime minDate = currentDate.subtract(const Duration(days: 18 * 365));
    DateTime maxDate = currentDate.subtract(const Duration(days: 50 * 365));

    return date.isBefore(minDate) && date.isAfter(maxDate);
  }
}
