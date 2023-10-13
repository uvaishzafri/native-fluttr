import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/model/native.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_simple_button.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
          const NativeMediumBodyText('Enter your date of birth, we will generate your native card and help you find your match'),
          const SizedBox(height: 42),
          SizedBox(
              height: 200,
              child: DatePickerWidget(
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
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => confirmationDialog(),
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
          child: photoUpload(),
        ),
      ),
    );
  }

  Widget confirmationDialog() {
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
                  context.router.pop();
                  //     var sarah = Native(
                  //       user: "Sarah Clay",
                  //       age: '31 yrs',
                  // imageUrl: 'assets/home/ic_test.png',
                  //       type: NativeType.fields(),
                  //       energy: 33,
                  //       goodFits: [
                  //         NativeType.moon(),
                  //         NativeType.mist(),
                  //         NativeType.mineral(),
                  //       ],
                  //     );
                  var overlayItem = Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: NativeButton(
                      isEnabled: true,
                      text: 'Next',
                      onPressed: () => context.router.push(const HowToChoosePartnerLoaderRoute()),
                    ),
                  );

                  context.router.push(NativeCardScaffold(nativeUser: usersList.first, overlayItem: overlayItem));
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
