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
          // const LinearProgressIndicator(value: 1 / 3),
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
                decoration: const BoxDecoration(shape: BoxShape.circle),
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
                    builder: (context) => photoPickerBottomSheet(),
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
        body: BlocProvider(
          create: (_) => getIt<ProfileCubit>(),
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
                  context.router.push(const OtherDetailsRoute());
                },
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

  Widget photoPickerBottomSheet() {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            onTap: () async {
              final imagePicker = ImagePicker();
              final imageXFile = await imagePicker.pickImage(source: ImageSource.gallery);
              if (imageXFile != null) {
                _imageFile = File(imageXFile.path);
                setState(() {});
              }
            },
            leading: const Icon(Icons.file_upload_outlined),
            title: const NativeSmallTitleText('Upload from your device'),
          ),
          const SizedBox(height: 2),
          ListTile(
            onTap: () async {
              final imagePicker = ImagePicker();
              final imageXFile = await imagePicker.pickImage(source: ImageSource.camera);
              if (imageXFile != null) {
                _imageFile = File(imageXFile.path);
                setState(() {});
              }
            },
            leading: const Icon(Icons.camera_alt_outlined),
            title: const NativeSmallTitleText('Click a picture'),
          )
        ],
      ),
    );
  }
}
