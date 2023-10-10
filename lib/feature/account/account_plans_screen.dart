import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

@RoutePage()
class AccountPlansScreen extends StatefulWidget {
  const AccountPlansScreen({super.key});

  @override
  State<AccountPlansScreen> createState() => _AccountPlansScreenState();
}

class _AccountPlansScreenState extends State<AccountPlansScreen> {
  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset('assets/playing_cards.svg'),
        const SizedBox(height: 30),
        Container(
          color: ColorUtils.purple,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NativeMediumTitleText(
                'Subscribers get more benefits',
                color: ColorUtils.white,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2)
            },
            children: [
              TableRow(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ColorUtils.textLightGrey.withOpacity(0.2)))),
                children: const [
                  SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: [
                      NativeMediumTitleText(
                        'native.',
                        color: ColorUtils.purple,
                      ),
                      NativeMediumBodyText('Free')
                    ],
                  ),
                  Column(
                    children: [
                      NativeMediumTitleText(
                        'native.',
                        color: ColorUtils.purple,
                      ),
                      NativeMediumBodyText('Plus')
                    ],
                  ),
                ],
              ),
              const TableRow(children: [
                SizedBox(height: 60, child: NativeLargeBodyText('Likes')),
                Center(child: NativeMediumBodyText('30')),
                Center(child: NativeMediumBodyText('Unlimited')),
              ]),
              const TableRow(children: [
                SizedBox(height: 60, child: NativeLargeBodyText('See everyone who likes you')),
                Icon(Icons.close),
                Icon(Icons.check),
              ]),
              const TableRow(children: [
                SizedBox(height: 60, child: NativeLargeBodyText('native. card based search')),
                Icon(Icons.close),
                Icon(Icons.check),
              ]),
            ],
          ),
        ),
        const Spacer(),
        // const SizedBox(height: 30),
        const Text(
          'Launching soon!',
          style: TextStyle(color: ColorUtils.purple, fontSize: 18, fontWeight: FontWeight.w600, height: 22 / 18),
        ),
        const SizedBox(height: 40),
      ],
    );

    Widget trailing = IconButton(
      onPressed: () {
        context.router.pop();
      },
      icon: const Icon(Icons.close_outlined),
    );

    return CommonScaffold(
      'Account plan',
      content,
      trailing: trailing,
    );
  }
}
