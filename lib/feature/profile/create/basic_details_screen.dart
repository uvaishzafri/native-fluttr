import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/profile/create/create_profile_scaffold.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/string_ext.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';

enum Gender {
  male,
  female,
  others
}

@RoutePage()
class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  Gender _selectedGender = Gender.male;
  String? selectedLocation;
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController aboutYouTextEditingController = TextEditingController();
  final TextEditingController locationSearchTextController = TextEditingController();

  List<String> items = [
    'Bengaluru',
    'Mumbai',
    'Delhi',
    'Chennai',
    'Pune'
  ];

  @override
  void dispose() {
    nameTextEditingController.dispose();
    aboutYouTextEditingController.dispose();
    locationSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget basicDetails() {
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
              nameTextEditingController,
              hintText: 'Name',
            ),
            const SizedBox(height: 28),
            const NativeSmallBodyText('About you'),
            NativeTextField(
              aboutYouTextEditingController,
              hintText: 'Tell us about your IKIGAI, when do you feel the most happiest? Eg: while playing with puppies',
              maxLength: 100,
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            const NativeSmallBodyText('Location'),
            NativeDropdown(
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              value: selectedLocation,
              searchController: locationSearchTextController,
              items: items
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
                  .map((e) => Container(
                        height: 111,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: _selectedGender == e ? ColorUtils.aquaGreen : ColorUtils.grey),
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
                                  fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                    return ColorUtils.aquaGreen;
                                  }),
                                  visualDensity: const VisualDensity(horizontal: -4),
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
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            NativeButton(
              isEnabled: true,
              text: 'Next',
              onPressed: () {
                context.router.push(const PhotoUploadRoute());
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
          child: basicDetails(),
        ),
      ),
    );
  }
}
