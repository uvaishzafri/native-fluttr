import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_switch.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

@RoutePage()
class SocialAccountSettingsScreen extends StatefulWidget {
  const SocialAccountSettingsScreen({super.key});

  @override
  State<SocialAccountSettingsScreen> createState() => _SocialAccountSettingsScreenState();
}

class _SocialAccountSettingsScreenState extends State<SocialAccountSettingsScreen> {
  bool _instagramSelected = true;
  bool _twitterSelected = true;
  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        const NativeMediumTitleText('Connect or deactivate your social media accounts here'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NativeLargeBodyText('Instagram'),
              NativeSwitch(
                value: _instagramSelected,
                onChanged: (value) {
                  setState(() {
                    _instagramSelected = value;
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
              const NativeLargeBodyText('Twitter'),
              NativeSwitch(
                value: _twitterSelected,
                onChanged: (value) {
                  setState(() {
                    _twitterSelected = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
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
      icon: const Icon(Icons.close_outlined),
    );

    return CommonScaffoldWithPadding(
      'Edit profile',
      content,
      trailing: trailing,
    );
  }
}
