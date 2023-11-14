import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/theme/theme.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateSystemUi();
    });
  }

  _updateSystemUi() {
    updateSystemUi(context, Theme.of(context).colorScheme.primaryContainer,
        ColorUtils.aquaGreen);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset('assets/playing_cards.svg'),
        const SizedBox(height: 30),
        Container(
          color: ColorUtils.purple,
          padding: const EdgeInsets.symmetric(vertical: 6),
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
            columnWidths: const {0: FlexColumnWidth(2)},
            children: [
              TableRow(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: ColorUtils.textLightGrey.withOpacity(0.2)))),
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
              TableRow(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: const NativeLargeBodyText('Likes')),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16),
                    child: const NativeMediumBodyText('30')),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16),
                    child: const NativeMediumBodyText('Unlimited')),
              ]),
              TableRow(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: const NativeLargeBodyText(
                        'See everyone who likes you')),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16),
                    child: const Icon(Icons.close)),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16),
                    child: const Icon(Icons.check)),
              ]),
              TableRow(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child:
                        const NativeLargeBodyText('native. card based search')),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16),
                    child: const Icon(Icons.close)),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16),
                    child: const Icon(Icons.check)),
              ]),
            ],
          ),
        ),
        const Spacer(),
        // const SizedBox(height: 30),
        const Text(
          'Launching soon!',
          style: TextStyle(
              color: ColorUtils.purple,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 22 / 18),
        ),
        const SizedBox(height: 40),
      ],
    );

    Widget trailing = IconButton(
      onPressed: () {
        context.router.pop();
      },
      icon: Icon(Icons.close_outlined,
          size: 20, color: Theme.of(context).colorScheme.surface),
    );

    return CommonScaffold(
      'Account plan',
      content,
      trailing: trailing,
    );
  }
}
