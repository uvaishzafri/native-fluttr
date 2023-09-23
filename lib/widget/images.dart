import 'package:flutter/material.dart';

class NativeHeadImage extends StatelessWidget {
  const NativeHeadImage(
    this.headPic, {
    required this.borderColor,
    required this.radius,
    this.borderRadius = 5,
    this.isGradientBorder = true,
    Key? key,
  }) : super(key: key);

  final Image headPic;
  final bool isGradientBorder;
  final Color borderColor;
  final int borderRadius;
  final int radius;

  @override
  Widget build(BuildContext context) => Container(
        height: (radius + borderRadius) * 2,
        width: (radius + borderRadius) * 2,
        padding: EdgeInsets.all(borderRadius.toDouble()),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !isGradientBorder ? borderColor : null,
            gradient: !isGradientBorder
                ? null
                : const LinearGradient(
                    colors: [
                      Color(0xFFBE94C6),
                      Color(0xFF7BC6CC),
                    ],
                  )),
        child: CircleAvatar(
          radius: radius.toDouble(),
          backgroundImage: headPic.image,
        ),
      );

  // Future<void> _launchUrl(Uri url) async {
  //   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
}
