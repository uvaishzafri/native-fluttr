import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/model/fav_card/fav_card_category.dart';
import 'package:native/util/fav_card/fav_card_constants.dart';

import '../../i18n/translations.g.dart';

class FavCardCategory extends StatelessWidget {
  const FavCardCategory({super.key, required this.model, required this.radius, this.textStyle, this.isCaps, this.isSelected});

  final FavCardCategoryModel model;
  final double radius;
  final TextStyle? textStyle;
  final bool? isCaps;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected == true ? model.color : Colors.transparent,
                )),
            SvgPicture.asset(
              model.imageAddress,
              width: radius * 1.23,
              height: radius * 1.23,
              color: isSelected == true ? Colors.white : model.color,
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          (isCaps ?? false) ? model.name.stringify().capitalize : model.name.stringify().capitalize,
          style: textStyle ??
              GoogleFonts.poppins().copyWith(
                color: model.color,
                fontSize: 12,
                fontWeight: isSelected == true ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 1.6,
                height: 22 / 8,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
