
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

@RoutePage()
class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key, required this.photoUrl});
  final String photoUrl;
  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  // File? _imageFile;
  @override
  Widget build(BuildContext context) {
    Widget bodyWidget() {
      return Column(
        children: [
          const SizedBox(height: 32),
          const CupertinoNavigationBar(
            border: Border(),
            backgroundColor: Colors.transparent,
            middle: NativeMediumTitleText('Create your profile'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              // height: 560,
              width: double.infinity,
              decoration:
                  BoxDecoration(image: DecorationImage(image: NetworkImage(widget.photoUrl), fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(height: 8),
          NativeButton(
            isEnabled: true,
            text: 'Next',
            onPressed: () async {
              context.router.push(const OtherDetailsRoute());
            },
          ),
          const SizedBox(height: 40),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
          child: bodyWidget(),
        ),
      ),
    );
  }
}
