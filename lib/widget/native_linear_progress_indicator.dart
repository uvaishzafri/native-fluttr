import 'package:flutter/material.dart';

class NativeLinearProgressIndicator extends StatelessWidget {
  final double? progress;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Color? baseColor;
  final Gradient? gradient;
  final Gradient? baseGradient;
  final Duration? animatedDuration;

  const NativeLinearProgressIndicator({
    Key? key,
    this.progress,
    this.height = 8,
    this.width,
    this.borderRadius,
    this.gradient,
    this.baseGradient,
    this.animatedDuration,
    this.color,
    this.baseColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        progress == null
            ? Container(
                width: width ?? MediaQuery.of(context).size.width,
                height: height,
                decoration: BoxDecoration(
                  color: color ?? Colors.grey,
                  gradient: gradient,
                  borderRadius: borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: borderRadius ?? BorderRadius.zero,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(baseColor ?? Colors.blue),
                  ),
                ),
              )
            : Stack(
                children: [
                  //base
                  Container(
                    height: height,
                    width: width ?? MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: baseColor ?? Colors.grey,
                      borderRadius: borderRadius,
                      gradient: baseGradient,
                    ),
                  ),

                  //progress
                  TweenAnimationBuilder(
                    curve: Curves.linear,
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: animatedDuration ?? const Duration(seconds: 0),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return LayoutBuilder(
                        builder: (BuildContext context,
                            BoxConstraints boxConstraints) {
                          return Container(
                            width: value * boxConstraints.maxWidth,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: color ?? Colors.blue,
                              gradient: gradient,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
