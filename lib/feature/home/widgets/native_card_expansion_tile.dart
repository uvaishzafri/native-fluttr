import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/color_utils.dart';

class NativeCardExpansionTile extends StatelessWidget {
  final String title;
  final String leadingImageAddress;
  final Widget expandedWidget;

  const NativeCardExpansionTile(
      {super.key,
      required this.title,
      required this.leadingImageAddress,
      required this.expandedWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: ColorUtils.white, borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.all(10),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading:
                SvgPicture.asset(leadingImageAddress, width: 15, height: 15),
            title: Text(
              title,
              style: GoogleFonts.poppins().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFBE94C6)),
            ),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                child: Column(
                  children: [
                    const DottedLine(dashColor: Colors.black),
                    const SizedBox(height: 20),
                    expandedWidget,
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
