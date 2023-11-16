import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native/widget/text/native_small_title_text.dart';

class PhotoPickerWidget extends StatelessWidget {
  const PhotoPickerWidget({super.key, required this.onFilePicked});
  final Function onFilePicked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            onTap: () async {
              // context.router.pop();
              final imagePicker = ImagePicker();
              final imageXFile =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              if (imageXFile != null) {
                var _imageFile = File(imageXFile.path);
                // setState(() {});
                if (context.mounted) {
                  context.router.pop();
                }
                onFilePicked(_imageFile);
              }
            },
            leading: const Icon(Icons.file_upload_outlined),
            title: const NativeSmallTitleText('Upload from your device'),
          ),
          const SizedBox(height: 2),
          ListTile(
            onTap: () async {
              // context.router.pop();
              final imagePicker = ImagePicker();
              final imageXFile =
                  await imagePicker.pickImage(source: ImageSource.camera);
              if (imageXFile != null) {
                var _imageFile = File(imageXFile.path);
                // setState(() {});
                if (context.mounted) {
                  context.router.pop();
                }
                onFilePicked(_imageFile);
              }
            },
            leading: const Icon(Icons.camera_alt_outlined),
            title: const NativeSmallTitleText('Click a picture'),
          )
        ],
      ),
    );
  }
}
