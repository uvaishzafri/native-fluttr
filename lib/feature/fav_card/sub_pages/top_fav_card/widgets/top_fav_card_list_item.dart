import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/fav_card/models/fav_card_items/fav_card_items.dart';
import 'package:native/feature/fav_card/sub_pages/top_fav_card/widgets/top_fav_card_category_list.dart';

import '../../../../../i18n/translations.g.dart';
import '../cubit/top_fav_card_cubit.dart';

enum Options { edit, delete }

class TopFavCardListItem extends StatelessWidget {
  final FavCardItemModel item;
  final int height;
  final Data state;

  TopFavCardListItem(
      {super.key,
      required this.item,
      required this.height,
      required this.state});

  Options? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final topFavCardCubit = BlocProvider.of<TopFavCardCubit>(context);
    return SizedBox(
      height: height * 1,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.8,
            child: DottedBorder(
                color: const Color(0xFFBE94C6),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: Image.network(item.imageAddress).image,
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(height * 0.25)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item.name,
                                      style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    TopFavCardCategoryList(item: item),
                                  ],
                                ),

                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: PopupMenuButton<Options>(
                                    padding: EdgeInsets.zero,
                                    iconSize: 16,
                                    icon: SvgPicture.asset(
                                        "assets/fav_card/dot_menu.svg",
                                        width: 16,
                                        height: 16),
                                    initialValue: selectedMenu,
                                    // Callback that sets the selected popup menu item.
                                    onSelected: (Options option) {
                                      if (option == Options.edit) {
                                        context.router
                                            .push(ItemCommentRoute(item: item));
                                      } else if (option == Options.delete) {
                                        topFavCardCubit.removeFavCard(
                                            favCard: item, state: state);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<Options>>[
                                      PopupMenuItem<Options>(
                                        value: Options.edit,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                                child: Icon(Icons.edit_outlined,
                                                    size: 15)),
                                            const SizedBox(width: 5),
                                            Text(
                                              t.strings.edit,
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<Options>(
                                        value: Options.delete,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                                child: Icon(
                                                    Icons.delete_outline,
                                                    size: 15,
                                                    color: Colors.red)),
                                            const SizedBox(width: 5),
                                            Text(
                                              t.strings.delete,
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () => {},
                                //   child: SvgPicture.asset("assets/fav_card/dot_menu.svg", width: 16, height: 16),
                                // )
                              ],
                            ),
                            Text(item.comment ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins().copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF7B7B7B)))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
