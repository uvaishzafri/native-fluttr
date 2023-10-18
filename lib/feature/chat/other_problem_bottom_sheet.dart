import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/chat/problem_submitted_bottom_sheet.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

class OtherProblemBottomSheet extends StatefulWidget {
  const OtherProblemBottomSheet({super.key});

  @override
  State<OtherProblemBottomSheet> createState() => _OtherProblemBottomSheetState();
}

class _OtherProblemBottomSheetState extends State<OtherProblemBottomSheet> {
  late final TextEditingController _otherReasonTextController;

  @override
  void initState() {
    super.initState();
    _otherReasonTextController = TextEditingController();
  }

  @override
  void dispose() {
    _otherReasonTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 400,
      child: Padding(
        padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: MediaQuery.of(context).viewInsets.bottom + 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(height: 20),
            NativeMediumTitleText('Report a Problem'),
            const SizedBox(height: 20),
            NativeTextField(
              _otherReasonTextController,
              onChanged: (value) {
                setState(() {});
              },
              maxLines: 6,
              hintText: 'Your concern matters to us, please let us know why you would like to report the user',
            ),
            // Spacer(),
            const SizedBox(height: 20),
            NativeButton(
              isEnabled: _otherReasonTextController.text.isNotEmpty,
              text: 'Submit',
              onPressed: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ProblemSubmittedBottomSheet(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
