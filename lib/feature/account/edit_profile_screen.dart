import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Map<String, List<String>> items = {
    'Christian': [
      'Catholic',
      'Russian',
      'Syriac',
    ],
    'Hindu': [
      'Bengali',
      'Brahmin',
      'Marwadi'
    ],
    'Buddhist': [
      'Bengali',
      'Brahmin',
      'Marwadi'
    ],
    'Muslim': [
      'Bengali',
      'Brahmin',
      'Marwadi'
    ],
    'Jain': [
      'Bengali',
      'Brahmin',
      'Marwadi'
    ],
  };
  final TextEditingController locationSearchTextController = TextEditingController();
  String? selectedLocation;

  List<String> locations = [
    'Bengaluru',
    'Mumbai',
    'Delhi',
    'Chennai',
    'Pune'
  ];

  String? selectedReligion;
  String? selectedCommunity;
  final TextEditingController religionSearchController = TextEditingController();
  final TextEditingController communitySearchController = TextEditingController();
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController aboutYouTextEditingController = TextEditingController();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Stack(
              children: [
                Container(
                  height: 125,
                  width: 125,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtils.grey),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => const Placeholder(),
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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: NativeSmallTitleText('Sarah Clay'),
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
          NativeDropdown<String>(
            onChanged: (value) {
              setState(() {
                selectedLocation = value;
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
                selectedCommunity = null;
              });
            },
            value: selectedReligion,
            searchController: religionSearchController,
            items: items.keys
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: NativeMediumBodyText(item),
                    ))
                .toList(),
          ),
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
              items: selectedReligion != null
                  ? items[selectedReligion]!
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: NativeMediumBodyText(item),
                          ))
                      .toList()
                  : null),
          const SizedBox(height: 30),
          NativeButton(
            isEnabled: true,
            text: 'Save',
            onPressed: () {
              // context.router.push(const );
            },
          ),
          const SizedBox(height: 40),
        ],
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
