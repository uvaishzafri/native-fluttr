import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

class NativeSwitch extends StatelessWidget {
  const NativeSwitch({super.key, required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return ColorUtils.purple.withOpacity(0.5);
        }
        return ColorUtils.purple; // Use the default color.
      }),
      thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return ColorUtils.purple.withOpacity(0.5);
        }
        return ColorUtils.purple; // Use the default color.
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) => Colors.transparent),
      trackOutlineWidth: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states) => 4.0),
      value: value,
      onChanged: onChanged,
    );
  }
}
