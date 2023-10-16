import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:native/feature/home/native_card_details_screen.dart';
import 'package:native/model/native.dart';

@RoutePage()
class NativeCardScaffold extends StatelessWidget {
  const NativeCardScaffold({super.key, required this.nativeUser, this.overlayItem});
  final Native? nativeUser;
  final Widget? overlayItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        NativeCardDetailsScreen(nativeUser: nativeUser),
        if (overlayItem != null) overlayItem!,
      ],
    );
  }
}
