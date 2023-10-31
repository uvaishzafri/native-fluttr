import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/account/cubit/edit_profile_cubit.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/profile/cubit/profile_cubit.dart';
import 'package:native/model/user.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/widget/common_scaffold.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/photo_picker_widget.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController locationSearchTextController = TextEditingController();
  String? selectedLocation;

  String? selectedReligion;
  String? selectedCommunity;
  final TextEditingController religionSearchController = TextEditingController();
  final TextEditingController communitySearchController = TextEditingController();
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController aboutYouTextEditingController = TextEditingController();
  File? _imageFile;
  // Future<User?>? _user;
  bool valueChanged = false;
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserDetails();
    });
  }

  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    _user = User.fromJson(jsonDecode(prefs.getString('user') ?? ""));
    nameTextEditingController.text = _user?.displayName ?? '';
    aboutYouTextEditingController.text = _user?.customClaims?.about ?? '';
    selectedCommunity = _user?.customClaims?.community! ?? '';
    selectedLocation = _user?.customClaims?.location! ?? '';
    selectedReligion = _user?.customClaims?.religion! ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    religionSearchController.dispose();
    communitySearchController.dispose();
    nameTextEditingController.dispose();
    aboutYouTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = SingleChildScrollView(
      child: BlocProvider<EditProfileCubit>.value(
        value: getIt<EditProfileCubit>(),
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            state.map(
              initial: (_) {},
              loading: (value) {
                if (!context.loaderOverlay.visible) {
                  context.loaderOverlay.show();
                }
              },
              error: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                if (value.appException is UnauthorizedException) {
                  BlocProvider.of<AppCubit>(context).logout();
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.appException.message),
                ));
              },
              success: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                // nameTextEditingController.text = value.user.displayName ?? '';
                // aboutYouTextEditingController.text = value.user.customClaims!.about ?? '';
                // selectedCommunity = value.user.customClaims!.community!;
                // selectedLocation = value.user.customClaims!.location!;
                // selectedReligion = value.user.customClaims!.religion!;

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Update successful'),
                ));
              },
            );
          },
          builder: (context, state) {
            // if (state is EditProfileSuccessState) {
            if (_user == null) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Stack(
                    children: [
                      Container(
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.grey,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _imageFile != null
                                ? Image.file(_imageFile!, fit: BoxFit.cover) as ImageProvider
                                : CachedNetworkImageProvider(_user!.photoURL!),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
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
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: ColorUtils.white,
                              size: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NativeSmallTitleText(_user!.displayName!),
                  ),
                ),
                const SizedBox(height: 20),
                const NativeSmallBodyText('Name'),
                NativeTextField(
                  nameTextEditingController,
                  hintText: 'Name',
                  onChanged: (value) {
                    setState(() {
                      valueChanged = true;
                    });
                  },
                ),
                const SizedBox(height: 28),
                const NativeSmallBodyText('About you'),
                NativeTextField(
                  aboutYouTextEditingController,
                  hintText:
                      'Tell us about your IKIGAI, when do you feel the most happiest? Eg: while playing with puppies',
                  maxLength: 100,
                  maxLines: 6,
                  onChanged: (value) {
                    setState(() {
                      valueChanged = true;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const NativeSmallBodyText('Location'),
                NativeDropdown<String>(
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                      valueChanged = true;
                    });
                  },
                  value: selectedLocation,
                  searchController: locationSearchTextController,
                  items: locations
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: NativeMediumBodyText(item),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                const NativeSmallBodyText('Religion'),
                const SizedBox(height: 8),
                NativeDropdown(
                  onChanged: (value) {
                    setState(() {
                      selectedReligion = value;
                      // selectedCommunity = null;
                      valueChanged = true;
                    });
                  },
                  value: selectedReligion,
                  searchController: religionSearchController,
                  items: religions.keys
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: NativeMediumBodyText(item),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 24),
                const NativeSmallBodyText('Language'),
                const SizedBox(height: 8),
                NativeDropdown(
                  onChanged: (value) {
                    setState(() {
                      selectedCommunity = value;
                      valueChanged = true;
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
                const SizedBox(height: 30),
                NativeButton(
                  isEnabled: _imageFile != null || valueChanged,
                  text: 'Save',
                  onPressed: () {
                    // context.router.push(const );
                    var editProfileBloc = BlocProvider.of<EditProfileCubit>(context);
                    User? user;
                    if (valueChanged) {
                      user = _user!.copyWith(
                        displayName: nameTextEditingController.text,
                        customClaims: _user!.customClaims!.copyWith(
                            community: selectedCommunity,
                            religion: selectedReligion,
                            location: selectedLocation,
                            about: aboutYouTextEditingController.text),
                      );
                    }
                    editProfileBloc.updateUserProfile(user: user, imageFile: _imageFile);
                  },
                ),
                const SizedBox(height: 40),
              ],
            );
            // } else {
            //   return SizedBox();
            // }
          },
        ),
      ),
    );

    Widget trailing = IconButton(
      onPressed: () {
        context.router.pop();
      },
      icon: const Icon(
        Icons.close_outlined,
        color: ColorUtils.white,
        size: 20,
      ),
    );
    return CommonScaffoldWithPadding(
      'Edit profile',
      content,
      trailing: trailing,
    );
  }
}
