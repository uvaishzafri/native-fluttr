import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

class ProblemSubmittedBottomSheet extends StatelessWidget {
  const ProblemSubmittedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          const SizedBox(height: 20),
          SvgPicture.asset('assets/chat/check_circle.svg'),
          const SizedBox(height: 20),
          const NativeMediumTitleText('Thanks, we’ve reveived your report'),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: NativeMediumBodyText(
              'We’ll take action against this account if we find that it goes against out Community Guidelines. Thanks for helping us keep native. a safe and supportive community.',
              color: ColorUtils.textLightGrey.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
