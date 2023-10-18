import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/chat/other_problem_bottom_sheet.dart';
import 'package:native/feature/chat/problem_submitted_bottom_sheet.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

class ReportUserBottomSheet extends StatefulWidget {
  const ReportUserBottomSheet({super.key});

  @override
  State<ReportUserBottomSheet> createState() => _ReportUserBottomSheetState();
}

class _ReportUserBottomSheetState extends State<ReportUserBottomSheet> {
  String? _selectedProblem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const NativeMediumTitleText('Report a Problem'),
          const SizedBox(height: 20),
          Flexible(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      dense: true,
                      onTap: () {
                        setState(() {
                          _selectedProblem = problems[index];
                        });
                      },
                      leading: _selectedProblem == problems[index] ? const Icon(Icons.check) : const SizedBox(),
                      title: NativeMediumBodyText(problems[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemCount: problems.length),
          ),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: NativeButton(
              isEnabled: _selectedProblem != null,
              text: 'Submit',
              onPressed: () {
                if (problems.indexOf(_selectedProblem!) < 5) {
                  // context.router.pop();
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const ProblemSubmittedBottomSheet(),
                  );
                } else {
                  // context.router.pop();
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const OtherProblemBottomSheet(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
