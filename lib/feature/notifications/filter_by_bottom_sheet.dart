import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

class FilterByBottomSheet extends StatefulWidget {
  const FilterByBottomSheet(
      {super.key,
      required this.isLikesSelected,
      required this.isChatsSelected,
      required this.onSubmit});
  final bool isLikesSelected;
  final bool isChatsSelected;
  final Function(bool, bool) onSubmit;
  @override
  State<FilterByBottomSheet> createState() => _FilterByBottomSheetState();
}

class _FilterByBottomSheetState extends State<FilterByBottomSheet> {
  late bool isLikesSelected;
  late bool isChatsSelected;
  @override
  void initState() {
    super.initState();
    isLikesSelected = widget.isLikesSelected;
    isChatsSelected = widget.isChatsSelected;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 480,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const NativeMediumTitleText('Filter by'),
                GestureDetector(
                    onTap: () {
                      isChatsSelected = true;
                      isLikesSelected = true;
                      setState(() {});
                      // isChatsSelected = false;
                      // isLikesSelected = false;
                      // Navigator.pop(context);
                      // widget.onSubmit(isLikesSelected, isChatsSelected);
                    },
                    child: const NativeSmallTitleText('Select all')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: ColorUtils.purple,
            activeColor: Colors.transparent,
            side: CustomMaterialStateBorderSide(),
            // side: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? BorderSide() : BorderSide()),
            value: isLikesSelected,
            onChanged: (value) {
              setState(() {
                isLikesSelected = value!;
              });
            },
            title: const NativeMediumBodyText('Likes'),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: ColorUtils.purple,
            activeColor: Colors.transparent,
            side: CustomMaterialStateBorderSide(),
            value: isChatsSelected,
            onChanged: (value) {
              setState(() {
                isChatsSelected = value!;
              });
            },
            title: const NativeMediumBodyText('Chat requests'),
          ),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: NativeButton(
              isEnabled: isLikesSelected || isChatsSelected,
              text: 'Apply',
              onPressed: () {
                Navigator.pop(context);
                widget.onSubmit(isLikesSelected, isChatsSelected);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMaterialStateBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(Set<MaterialState> states) {
    return states.contains(MaterialState.selected)
        ? BorderSide(color: ColorUtils.purple, width: 2)
        : BorderSide(color: ColorUtils.textGrey.withOpacity(0.8), width: 2);
  }
}
