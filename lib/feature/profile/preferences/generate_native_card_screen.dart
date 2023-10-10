import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';

@RoutePage()
class GenerateNativeCardScreen extends StatefulWidget {
  const GenerateNativeCardScreen({super.key});

  @override
  State<GenerateNativeCardScreen> createState() => _GenerateNativeCardScreenState();
}

class _GenerateNativeCardScreenState extends State<GenerateNativeCardScreen> {
  @override
  Widget build(BuildContext context) {
    Widget photoUpload() {
      return Column(
        children: [
          const SizedBox(height: 32),
          const NativeLargeBodyText('Generate native. card'),
          const SizedBox(height: 42),
          SvgPicture.asset('assets/girl_with_balloons.svg'),
          const SizedBox(height: 42),
          const NativeMediumBodyText('Enter your date of birth, we will generate your native card and help you find your match'),
          const SizedBox(height: 42),
          SizedBox(
              height: 200,
              child: DatePickerWidget(
                dateFormat: 'MMM/d/y',
                pickerTheme: DateTimePickerTheme(dividerColor: ColorUtils.textLightGrey.withOpacity(0.5), itemTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorUtils.purple)),
              )),
          const Spacer(),
          NativeButton(
            isEnabled: true,
            text: 'Generate',
            onPressed: () {},
          ),
          const SizedBox(height: 40),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
          child: photoUpload(),
        ),
      ),
    );
  }
}
