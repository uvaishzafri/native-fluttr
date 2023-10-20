import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/profile/cubit/profile_cubit.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_linear_progress_indicator.dart';
import 'package:native/widget/photo_picker_widget.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

@RoutePage()
class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key, required this.gender});
  final Gender gender;
  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    Widget photoUpload(ProfileCubit profileCubit) {
      return Column(
        children: [
          const SizedBox(height: 32),
          const CupertinoNavigationBar(
            border: Border(),
            backgroundColor: Colors.transparent,
            middle: NativeMediumTitleText('Create your profile'),
          ),
          const SizedBox(height: 8),
          NativeLinearProgressIndicator(
            progress: 1 / 3,
            gradient: ColorUtils.nativeGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 4),
          const NativeSmallBodyText(
            '1/3 done',
            color: ColorUtils.purple,
          ),
          const SizedBox(height: 20),
          const NativeSmallBodyText('Upload your picture'),
          const SizedBox(height: 42),
          Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 256,
                width: 231,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ColorUtils.aquaGreen, width: 2)),
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      )
                    : widget.gender != Gender.others
                        ? SvgPicture.asset(
                            "assets/profile/${widget.gender.name}.svg",
                            height: 256,
                            width: 231,
                            // colorFilter: ColorFilter.mode(ColorUtils.aquaGreen, BlendMode.srcIn),
                          )
                        : const SizedBox(),
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => PhotoPickerWidget(
                      onFilePicked: (file) {
                        setState(() {
                          _imageFile = file;
                        });
                      },
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.purple,
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: ColorUtils.white),
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          NativeButton(
            isEnabled: _imageFile != null,
            text: 'Next',
            onPressed: () async {
              if (_imageFile != null) {
                profileCubit.updateProfilePhoto(_imageFile!);
                // context.router.push(const OtherDetailsRoute());
              }
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
                  // if (context.loaderOverlay.visible) {
                  //   context.loaderOverlay.hide();
                  // }
                  // context.router.push( PhotoRoute(photoUrl: ));
                },
                photoUpdated: (value) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  context.router.push(PhotoRoute(photoUrl: value.photoUrl));
                },
                otherDetailsUpdated: (value) {},
              );
            },
            builder: (context, state) {
              final profileBloc = BlocProvider.of<ProfileCubit>(context);
              return Container(
                margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
                child: photoUpload(profileBloc),
              );
            },
          ),
        ),
      ),
    );
  }

}
