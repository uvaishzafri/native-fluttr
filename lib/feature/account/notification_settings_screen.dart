import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_switch.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool likesSelected = true;
  bool messagesSelected = true;
  bool chatsSelected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getStoredNotificationSettings();
    });
  }

  getStoredNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationSettingsJson = prefs.getString('notificationSettings');
    if (notificationSettingsJson != null) {
      final notificationSetting = jsonDecode(notificationSettingsJson);
      likesSelected = notificationSetting['likes'];
      messagesSelected = notificationSetting['messages'];
      setState(() {});
    }
  }

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
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 12.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const NativeLargeBodyText('Chat requests'),
        //       NativeSwitch(
        //         value: chatsSelected,
        //         onChanged: (value) {
        //           setState(() {
        //             chatsSelected = value;
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        const Spacer(),
        // const SizedBox(height: 30),
        NativeButton(
          isEnabled: true,
          text: 'Save',
          onPressed: () async {
            // context.router.push(const );
            context.loaderOverlay.show();
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'notificationSettings',
                jsonEncode({
                  'likes': likesSelected,
                  'messages': messagesSelected, /*'chatRequest': chatsSelected*/
                }));
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Notification settings saved.'),
              ));
            }
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
