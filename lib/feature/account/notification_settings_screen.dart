import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_switch.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

@RoutePage()
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool likesSelected = true;
  bool messagesSelected = true;
  bool chatsSelected = true;
  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NativeLargeBodyText('Likes on your profile'),
              NativeSwitch(
                value: likesSelected,
                onChanged: (value) {
                  setState(() {
                    likesSelected = value;
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NativeLargeBodyText('Messages'),
              NativeSwitch(
                value: messagesSelected,
                onChanged: (value) {
                  setState(() {
                    messagesSelected = value;
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NativeLargeBodyText('Chat requests'),
              NativeSwitch(
                value: chatsSelected,
                onChanged: (value) {
                  setState(() {
                    chatsSelected = value;
                  });
                },
              ),
              // Switch(
              //   trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              //     if (!states.contains(MaterialState.selected)) {
              //       return ColorUtils.purple.withOpacity(0.5);
              //     }
              //     return ColorUtils.purple; // Use the default color.
              //   }),
              //   thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              //     if (!states.contains(MaterialState.selected)) {
              //       return ColorUtils.purple.withOpacity(0.5);
              //     }
              //     return ColorUtils.purple; // Use the default color.
              //   }),
              //   trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) => Colors.transparent),
              //   trackOutlineWidth: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states) => 4.0),
              //   value: chatsSelected,
              //   onChanged: (value) {
              //     setState(() {
              //       chatsSelected = value;
              //     });
              //   },
              // ),
            ],
          ),
        ),
        const Spacer(),
        // const SizedBox(height: 30),
        NativeButton(
          isEnabled: true,
          text: 'Save',
          onPressed: () {
            // context.router.push(const );
          },
        ),
        const SizedBox(height: 30),
      ],
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
      'Notification settings',
      content,
      trailing: trailing,
    );
  }
}
