import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';

@RoutePage()
class OtherPreferencesScreen extends StatefulWidget {
  const OtherPreferencesScreen({super.key});

  @override
  State<OtherPreferencesScreen> createState() => _OtherPreferencesScreenState();
}

class _OtherPreferencesScreenState extends State<OtherPreferencesScreen> {
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
    Widget otherDetails() {
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
          const LinearProgressIndicator(value: 1 / 2),
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
              items: selectedReligion != null
                  ? items[selectedReligion]!
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: NativeMediumBodyText(item),
                          ))
                      .toList()
                  : null),
          const Spacer(),
          NativeButton(
            isEnabled: true,
            text: 'Next',
            onPressed: () {
              context.router.push(const GenerateNativeCardRoute());
            },
          ),
          const SizedBox(height: 40),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
          child: otherDetails(),
        ),
      ),
    );
  }
}
