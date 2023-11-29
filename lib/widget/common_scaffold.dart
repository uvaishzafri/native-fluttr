import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/theme/theme.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/text/native_large_title_text.dart';

class CommonScaffold extends StatelessWidget {
  final Widget content;
  final String title;
  final Widget? trailing;
  const CommonScaffold(this.title, this.content, {super.key, this.trailing});

  static commonScaffoldUpdateSystemUi(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateSystemUi(context, Theme.of(context).colorScheme.primaryContainer,
          ColorUtils.aquaGreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.aquaGreen,
        appBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(top: 20),
          automaticallyImplyLeading: false,
          border: const Border(),
          backgroundColor: ColorUtils.aquaGreen,
          middle: NativeLargeTitleText(
            title,
            color: ColorUtils.white,
          ),
          trailing: trailing,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: content,
              ),
            ),
          ],
        ));
  }
}
