import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/auth/bloc/auth_cubit.dart';
import 'package:native/feature/profile/create/create_profile_scaffold.dart';
import 'package:native/feature/profile/cubit/profile_cubit.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/user.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/util/string_ext.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';

@RoutePage()
class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  Gender _selectedGender = Gender.male;
  String? _selectedLocation;
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _aboutYouTextEditingController =
      TextEditingController();
  final TextEditingController _locationSearchTextController =
      TextEditingController();

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _aboutYouTextEditingController.dispose();
    _locationSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget basicDetails(ProfileCubit profileCubit) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Align(
              alignment: AlignmentDirectional.center,
              child: NativeMediumTitleText(
                'Create your profile',
              ),
            ),
            const SizedBox(height: 12),
            const LinearProgressIndicator(value: 0),
            const SizedBox(height: 4),
            const Align(
              child: NativeSmallBodyText(
                '0/3 done',
                color: ColorUtils.purple,
              ),
            ),
            const SizedBox(height: 20),
            const NativeSmallBodyText('Name'),
            NativeTextField(
              _nameTextEditingController,
              maxLength: 30,
              maxLines: 1,
              hintText: 'Name',
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 28),
            const NativeSmallBodyText('About you'),
            NativeTextField(
              _aboutYouTextEditingController,
              hintText:
                  'Tell us about your IKIGAI, when do you feel the most happiest? Eg: while playing with puppies',
              maxLength: 100,
              maxLines: 6,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            const NativeSmallBodyText('Location'),
            NativeDropdown(
              onChanged: (value) {
                setState(() {
                  _selectedLocation = value;
                });
              },
              value: _selectedLocation,
              searchController: _locationSearchTextController,
              items: locations
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: NativeMediumBodyText(item),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const NativeSmallBodyText('Gender'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Gender.values
                  .map((e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = e;
                          });
                        },
                        child: Container(
                          height: 111,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: _selectedGender == e
                                    ? ColorUtils.aquaGreen
                                    : ColorUtils.grey),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: e,
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null) {
                                          _selectedGender = value;
                                        }
                                      });
                                    },
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      return ColorUtils.aquaGreen;
                                    }),
                                    visualDensity:
                                        const VisualDensity(horizontal: -4),
                                  ),
                                  NativeMediumBodyText(
                                    e.name.capitalize(),
                                    fontWeight: FontWeight.w600,
                                  )
                                ],
                              ),
                              e != Gender.others
                                  ? SvgPicture.asset(
                                      "assets/profile/${e.name}.svg",
                                      height: 60,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            NativeButton(
              isEnabled: profileCubit.validateBasicDetails(
                _nameTextEditingController.text,
                _aboutYouTextEditingController.text,
                _selectedLocation,
              ),
              text: 'Next',
              onPressed: () async {
                // final profileBloc = BlocProvider.of<ProfileCubit>(context);
                final user = User(
                  displayName: _nameTextEditingController.text.trim(),
                  customClaims: CustomClaims(
                    about: _aboutYouTextEditingController.text.trim(),
                    location: _selectedLocation,
                    gender: _selectedGender,
                  ),
                );
                profileCubit.updateProfile(user);
                // context.router.push(PhotoUploadRoute(gender: _selectedGender));
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
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
                  // if (value.exception.message == 'unauthorized') {
                  //   BlocProvider.of<AppCubit>(context).logout();
                  //   return;
                  // }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(value.exception.message)));
                },
                profileUpdated: (_) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  context.router
                      .push(PhotoUploadRoute(gender: _selectedGender));
                },
                photoUpdated: (_) {},
                otherDetailsUpdated: (_) {},
              );
            },
            builder: (context, state) {
              final profileBloc = BlocProvider.of<ProfileCubit>(context);

              return Container(
                margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
                child: basicDetails(profileBloc),
              );
            },
          ),
        ),
      ),
    );
  }
}
