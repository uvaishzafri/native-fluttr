import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/widget/common_scaffold.dart';

class CommonScaffoldWithPadding extends StatelessWidget {
  final Widget content;
  final String title;
  final Widget? trailing;
  const CommonScaffoldWithPadding(this.title, this.content, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title,
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
        child: content,
      ),
      trailing: trailing,
    );
    // return Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     backgroundColor: ColorUtils.aquaGreen,
    //     appBar: CupertinoNavigationBar(
    //       automaticallyImplyLeading: false,
    //       border: const Border(),
    //       backgroundColor: ColorUtils.aquaGreen,
    //       middle: NativeLargeTitleText(
    //         title,
    //         color: ColorUtils.white,
    //       ),
    //       trailing: trailing,
    //     ),
    //     body: Column(
    //       children: [
    //         const SizedBox(height: 20),
    //         Expanded(
    //           child: Container(
    //             decoration: const BoxDecoration(
    //               color: ColorUtils.white,
    //               borderRadius: BorderRadius.vertical(
    //                 top: Radius.circular(20),
    //               ),
    //             ),
    //             padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
    //             child: content,
    //           ),
    //         ),
    //       ],
    //     ));
  }
}
