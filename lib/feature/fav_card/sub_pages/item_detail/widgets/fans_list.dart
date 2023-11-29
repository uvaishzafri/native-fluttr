import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/fav_card/models/fan_model.dart';
import 'package:native/widget/like_dialog.dart';

import '../../../../../model/user.dart';
import '../../../../../widget/like_overlay.dart';
import '../../../../app/app_router.gr.dart';

class FansList extends StatelessWidget {
  final List<FanModel> fans;

  const FansList({super.key, required this.fans});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: fans.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          FanModel fan = fans[index];
          User fanUser = fan.user;
          return GestureDetector(
            onTap: () {
              var overlayItem = LikeOverlay(
                onPressedLike: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LikeDialog(),
                  );
                },
                isTutorial: false,
              );
              context.router.push(NativeCardScaffold(
                  user: fanUser, overlayItem: overlayItem, isDemoUser: true));
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(fanUser.photoURL ?? ""),
                      fit: BoxFit.cover,
                    ),
                    shape: const OvalBorder(),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fanUser.displayName ?? "",
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    // If the user has added some comment for the favCard then use that otherwise use their bio. If none of this is present
                    // then display empty string
                    Text(
                        (fan.comment.isNotEmpty)
                            ? (fan.comment)
                            : (fanUser.customClaims?.about ?? ""),
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400))
                  ],
                ),
                const Spacer(),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward_ios))
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 20),
      ),
    );
  }
}
