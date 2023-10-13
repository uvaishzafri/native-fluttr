import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

const _assetFolder = 'assets/home';

class HomeScaffold extends StatelessWidget {
  final Widget content;
  const HomeScaffold(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  floating: false,
                  expandedHeight: 69.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(
                        //   height: 69,
                        // ),
                        SvgPicture.asset("$_assetFolder/ic_logo_black.svg"),
                      ],
                    ),
                  )),
              SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Container(margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
                      child: content);
                }, childCount: 1),
              ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              //     return Container(
              //         margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
              //         child: SingleChildScrollView(
              //           child: content,
              //         ));
              //   }, childCount: 1),
              // )
            ],
          )),
    );
  }
}
