import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/images.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/util/datetime_extension.dart';

class ExpandableNativeCard extends StatefulWidget {
  const ExpandableNativeCard({super.key, required this.native});
  final User native;
  @override
  State<StatefulWidget> createState() => _ExpandableNativeCardState();
}

class _ExpandableNativeCardState extends State<ExpandableNativeCard> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19616161),
                offset: Offset(10, 10),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                const Color(0xFFBE94C6).withOpacity(0.7),
                const Color(0xFF7BC6CC).withOpacity(0.7),
              ],
            )),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              expanded = value;
            });
          },
          title: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Hello ${widget.native.displayName}!",
                style: const TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset("assets/home/ic_hi.png")
            ]),
          ),
          trailing: Text(
            expanded ? "View less" : "Show Native card",
            style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 12,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xffffffff)),
            textAlign: TextAlign.center,
          ),
          children: [
            Container(
              height: 104,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NativeEnergyWidget(
                    energy: widget.native.native!.energyScore!,
                    radius: 27.5,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  NativeTypeWidget(type: getNativeTypeDetail(widget.native.native!.type!), radius: 27.5),
                  // NativeTypeWidget(type: getNativeTypeDetail(NativeTypeEnum.values.firstWhere((element) => element.name.toLowerCase() == widget.native.native!.type!.en!.toLowerCase() )), radius: 27.5),
                  const SizedBox(
                    width: 17,
                  ),
                  const VerticalDivider(
                    width: 1,
                    color: Color(0xFFFFFFFF),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  NativeGoodFitsWidget(types: widget.native.native!.matchTypes!.map((e) => getNativeTypeDetail(e!)).toList()),
                ],
              ),
            )
          ],
        ));
  }
}

class NativeEnergyWidget extends StatelessWidget {
  const NativeEnergyWidget(
      {
    super.key,
    required this.energy,
    required this.radius,
    this.titleFontSize,
    this.titleFontWeight,
    this.valueFontSize,
    this.valueFontWeight,
  });
  final int energy;
  final double radius;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final double? valueFontSize;
  final FontWeight? valueFontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFBE94C6),
              Color(0xFF7BC6CC),
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "native. energy",
            style: TextStyle(
              color: const Color(0xffffffff),
              fontSize: titleFontSize ?? 4,
              fontWeight: titleFontWeight ?? FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "$energy",
            style: TextStyle(
              color: const Color(0xffffffff),
              fontSize: valueFontSize ?? 12,
              fontWeight: valueFontWeight ?? FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class NativeTypeWidget extends StatelessWidget {
  const NativeTypeWidget({super.key, required this.type, required this.radius, this.textStyle, this.isCaps});
  final NativeType type;
  final double radius;
  final TextStyle? textStyle;
  final bool? isCaps;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
            image: DecorationImage(image: type.imageProvider, fit: BoxFit.contain),
          ),
        ),
        Text(
          isCaps ?? false ? type.name.toUpperCase() : type.name,
          style: textStyle ??
              const TextStyle(
            color: Color(0xff1E1E1E),
            fontSize: 8,
            fontWeight: FontWeight.w500,
                letterSpacing: 1.6,
                height: 22 / 8,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class NativeGoodFitsWidget extends StatelessWidget {
  const NativeGoodFitsWidget({super.key, required this.types});
  final List<NativeType> types;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Good fit with",
          style: TextStyle(
            color: Color(0xff1E1E1E),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 7),
        Row(
          children: types.asMap().entries.map((e) {
            return Container(
                margin: EdgeInsets.only(left: e.key > 0 ? 17 : 0),
                child: Column(
                  children: [
                    Row(children: [
                      SvgPicture.asset('assets/home/ic_native_badge.svg'),
                      Text(
                        "No.${e.key + 1}",
                        style: const TextStyle(
                          color: Color(0xff1E1E1E),
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                    NativeTypeWidget(
                      type: e.value,
                      radius: 16,
                    ),
                  ],
                ));
          }).toList(),
        ),
      ],
    );
  }
}

class NativeUserCard extends StatelessWidget {
  const NativeUserCard(
      {super.key, required this.native});
  final User native;
  // final Image userImage;

  Widget _buildCard(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NativeHeadImage(
                    // Image.asset(native.imageUrl),
                    Image.network(native.photoURL!),
                    // userImage,
                    borderColor: Theme.of(context).colorScheme.primary,
                    radius: 43,
                    borderRadius: 3,
                    isGradientBorder: true,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      NativeEnergyWidget(energy: native.native!.energyScore!, radius: 20),
                      const SizedBox(
                        height: 8,
                      ),
                      NativeTypeWidget(type: getNativeTypeDetail(native.native!.type!), radius: 20),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              // width: 250,
              // width: double.infinity,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${native.displayName}, ${DateTime.tryParse(native.customClaims!.birthday!)?.ageFromDate()}',
                      style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      native.customClaims!.location!,
                      style: TextStyle(
                        color: Color(0xff787878),
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good fit with",
                    style: TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const DottedLine(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: native.native!.matchTypes!.asMap().entries.map((e) {
                      return Container(
                          margin: EdgeInsets.only(left: e.key > 0 ? 17 : 0),
                          child: Column(
                            children: [
                              Row(children: [
                                SvgPicture.asset('assets/home/ic_native_badge.svg'),
                                Text(
                                  "No.${e.key + 1}",
                                  style: const TextStyle(
                                    color: Color(0xff1E1E1E),
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                              NativeTypeWidget(
                                type: getNativeTypeDetail(e.value!),
                                radius: 16,
                              ),
                            ],
                          ));
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCard(context),
        Positioned(
          right: 0,
          top: 0,
          child: Container(),
        ),
      ],
    );
  }
}

class BigNativeUserCard extends StatelessWidget {
  const BigNativeUserCard({super.key, required this.native, required this.user});
  final NativeCard native;
  final User user;
  // final Image userImage;

  Widget _buildCard(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: ColorUtils.aquaGreen.withOpacity(0.6)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      NativeMediumTitleText(
                        '${user.displayName}, ${DateTime.tryParse(user.customClaims!.birthday!)?.ageFromDate()}',
                        color: ColorUtils.white,
                        fontWeight: FontWeight.w600,
                      ),
                      NativeSmallBodyText(
                        user.customClaims!.location!,
                        color: ColorUtils.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: ColorUtils.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NativeHeadImage(
                    // Image.asset(native.imageUrl),
                    Image.network(user.photoURL!),
                    // userImage,
                    borderColor: Theme.of(context).colorScheme.primary,
                    radius: 97,
                    borderRadius: 6,
                    isGradientBorder: true,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      NativeEnergyWidget(
                        energy: native.meta!.energyScore!,
                        radius: 50,
                        titleFontSize: 10,
                        titleFontWeight: FontWeight.w500,
                        valueFontSize: 30,
                      ),
                      const SizedBox(height: 8),
                      NativeTypeWidget(
                        type: getNativeTypeDetail(native.meta!.type!),
                        radius: 50,
                        isCaps: true,
                        textStyle: const TextStyle(
                          color: ColorUtils.textGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.8,
                          height: 22 / 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: ColorUtils.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good fit with",
                    style: TextStyle(
                      color: ColorUtils.textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 22 / 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const DottedLine(dashGapLength: 2, dashLength: 3),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // children: native.meta.matchTypes.
                    children: native.meta!.matchTypes!.asMap().entries.map((e) {
                      return Container(
                          margin: EdgeInsets.only(left: e.key > 0 ? 17 : 0),
                          child: Column(
                            children: [
                              Row(children: [
                                SvgPicture.asset(
                                  'assets/home/ic_native_badge.svg',
                                  height: 16,
                                ),
                                Text(
                                  "No.${e.key + 1}",
                                  style: const TextStyle(
                                    color: Color(0xff1E1E1E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 22 / 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                              NativeTypeWidget(
                                type: getNativeTypeDetail(e.value!),
                                radius: 31,
                                textStyle: const TextStyle(
                                  color: ColorUtils.textGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 22 / 14,
                                  letterSpacing: 2.8,
                                ),
                              ),
                            ],
                          ));
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              color: ColorUtils.purple.withOpacity(0.6),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: NativeMediumBodyText(
                    'Honest, Responsible & Fair minded',
                    color: ColorUtils.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCard(context),
        Positioned(
          right: 0,
          top: 0,
          child: Container(),
        ),
      ],
    );
  }
}
