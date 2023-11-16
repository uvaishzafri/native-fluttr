import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/chat/cubit/report_user_cubit.dart';
import 'package:native/feature/chat/problem_submitted_bottom_sheet.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

class OtherProblemBottomSheet extends StatefulWidget {
  const OtherProblemBottomSheet({super.key, required this.userId});
  final String userId;

  @override
  State<OtherProblemBottomSheet> createState() =>
      _OtherProblemBottomSheetState();
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
    return BlocProvider<ReportUserCubit>.value(
      value: getIt<ReportUserCubit>(),
      child: BlocConsumer<ReportUserCubit, ReportUserState>(
        listener: (context, state) {
          // TODO: implement listener
          state.map(
            initial: (value) {},
            loading: (value) {
              if (!context.loaderOverlay.visible) {
                context.loaderOverlay.show();
              }
            },
            errorState: (value) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              if (value.appException is UnauthorizedException) {
                BlocProvider.of<AppCubit>(context).logout();
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value.appException.message),
                ),
              );
            },
            successState: (value) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) => const ProblemSubmittedBottomSheet(),
              );
            },
          );
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<ReportUserCubit>(context);
          return SizedBox(
            // height: 400,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 32,
                  left: 32,
                  right: 32,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 12),
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
                    hintText:
                        'Your concern matters to us, please let us know why you would like to report the user',
                  ),
                  // Spacer(),
                  const SizedBox(height: 20),
                  NativeButton(
                    isEnabled: _otherReasonTextController.text.isNotEmpty,
                    text: 'Submit',
                    onPressed: () {
                      bloc.reportUser(widget.userId, "CHAT",
                          _otherReasonTextController.text);
                      // Navigator.pop(context);
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (context) => const ProblemSubmittedBottomSheet(),
                      // );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
