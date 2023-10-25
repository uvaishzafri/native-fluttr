import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/string_ext.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

@RoutePage()
class BasicPrefrencesScreen extends StatefulWidget {
  const BasicPrefrencesScreen({super.key});

  @override
  State<BasicPrefrencesScreen> createState() => _BasicPrefrencesScreenState();
}

class _BasicPrefrencesScreenState extends State<BasicPrefrencesScreen> {
  Gender _selectedGender = Gender.male;
  final TextEditingController locationSearchTextController = TextEditingController();
  SfRangeValues minMaxAge = const SfRangeValues(22, 40);
  String? selectedLocation;
  final TextEditingController _rangeStartController = TextEditingController(text: '22');
  final TextEditingController _rangeEndController = TextEditingController(text: '44');

  @override
  void dispose() {
    locationSearchTextController.dispose();
    _rangeStartController.dispose();
    _rangeEndController.dispose();

    super.dispose();
  }

  Widget _buildThumbIcon(TextEditingController controller) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: OverflowBox(
        maxWidth: 150,
        child: TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(color: ColorUtils.purple),
          decoration: const InputDecoration(
              fillColor: Colors.transparent,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              border: InputBorder.none,
              isDense: true),
          controller: controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget basicDetails() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const CupertinoNavigationBar(
            border: Border(),
            backgroundColor: Colors.transparent,
            middle: NativeMediumTitleText('What are you looking for?'),
          ),
          const SizedBox(height: 12),
          const LinearProgressIndicator(value: 0),
          const SizedBox(height: 4),
          const Align(
            child: NativeSmallBodyText(
              '0/2 done',
              color: ColorUtils.purple,
            ),
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
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          const NativeSmallBodyText('Age range'),
          const SizedBox(height: 10),
          SfRangeSliderTheme(
            data: SfRangeSliderThemeData(
              activeTrackColor: ColorUtils.aquaGreen,
            ),
            child: SfRangeSlider(
              min: 18,
              max: 50,
              stepSize: 1,
              startThumbIcon: _buildThumbIcon(_rangeStartController),
              endThumbIcon: _buildThumbIcon(_rangeEndController),
              showLabels: true,
              values: minMaxAge,
              onChangeStart: (SfRangeValues newValues) {
                _rangeStartController.text = newValues.start.toInt().toString();
                _rangeEndController.text = newValues.end.toInt().toString();
              },
              onChanged: (SfRangeValues newValues) {
                setState(() {
                  _rangeStartController.text = newValues.start.toInt().toString();
                  _rangeEndController.text = newValues.end.toInt().toString();
                  minMaxAge = newValues;
                });
              },
            ),
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
          const Spacer(),
          NativeButton(
            isEnabled: selectedLocation?.isNotEmpty ?? false,
            text: 'Next',
            onPressed: () {
              if (selectedLocation?.isEmpty ?? true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kindly select a location')));
              }
              context.router.push(
                OtherPreferencesRoute(
                    gender: _selectedGender,
                    minMaxAge: RangeValues(minMaxAge.start, minMaxAge.end),
                    location: selectedLocation!),
              );
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
          child: basicDetails(),
        ),
      ),
    );
  }
}
