import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/model/native.dart';
import 'package:native/widget/images.dart';

class ExpandableNativeCard extends StatefulWidget {
  ExpandableNativeCard({super.key, required this.native});
  Native native;
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
                "Hello ${widget.native.user}!",
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
                    energy: widget.native.energy,
                    radius: 27.5,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  NativeTypeWidget(type: widget.native.type, radius: 27.5),
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
                  NativeGoodFitsWidget(types: widget.native.goodFits),
                ],
              ),
            )
          ],
        ));
  }
}

class NativeEnergyWidget extends StatelessWidget {
  const NativeEnergyWidget(
      {super.key, required this.energy, required this.radius});
  final int energy;
  final double radius;

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
          const Text(
            "native. energy",
            style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 6,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            "$energy",
            style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 16,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class NativeTypeWidget extends StatelessWidget {
  const NativeTypeWidget({super.key, required this.type, required this.radius});
  final NativeType type;
  final double radius;

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
                image: DecorationImage(image: type.imageProvider))),
        Text(
          type.name,
          style: const TextStyle(
            color: Color(0xff1E1E1E),
            fontSize: 8,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            height: 2,
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
      {super.key, required this.native, required this.userImage});
  final Native native;
  final Image userImage;

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
                children: [
                  NativeHeadImage(
                    userImage,
                    borderColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    borderRadius: 3,
                    isGradientBorder: true,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      NativeEnergyWidget(energy: native.energy, radius: 15),
                      const SizedBox(
                        height: 8,
                      ),
                      NativeTypeWidget(type: native.type, radius: 15),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
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
                      native.user,
                      style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Osaka, Japan",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
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
                    // const DottedLine(),
                    const SizedBox(height: 12),
                    Row(
                      children: native.goodFits.asMap().entries.map((e) {
                        return Container(
                            margin: EdgeInsets.only(left: e.key > 0 ? 17 : 0),
                            child: Column(
                              children: [
                                Row(children: [
                                  SvgPicture.asset(
                                      'assets/home/ic_native_badge.svg'),
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
                )),
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
