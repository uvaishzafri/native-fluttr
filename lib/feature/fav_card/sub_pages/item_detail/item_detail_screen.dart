import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/feature/fav_card/sub_pages/item_detail/cubit/item_detail_cubit.dart';
import 'package:native/feature/fav_card/sub_pages/item_detail/widgets/fans_list.dart';
import 'package:native/feature/fav_card/sub_pages/widgets/item_header.dart';

import '../../../../di/di.dart';
import '../../../../i18n/translations.g.dart';
import '../../../app/app_router.gr.dart';
import '../../models/fav_card_items/fav_card_items.dart';

@RoutePage()
class ItemDetailScreen extends StatelessWidget {
  final FavCardItemModel item;
  final int noOfLikedFavCards;

  const ItemDetailScreen(
      {super.key, required this.item, required this.noOfLikedFavCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ItemDetailCubit>.value(
        value: getIt<ItemDetailCubit>()..getData(favCardId: item.id),
        child: BlocConsumer<ItemDetailCubit, ItemDetailState>(
            listener: (context, state) {
              state.map(
                initial: (value) {},
                loading: (value) {
                  if (!context.loaderOverlay.visible) {
                    context.loaderOverlay.show();
                  }
                },
                error: (value) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value.appException.message),
                  ));
                },
                data: (value) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                },
              );
            },
            buildWhen: (p, c) => p != c && c is Data,
            builder: (context, state) {
              final itemDetailCubit = BlocProvider.of<ItemDetailCubit>(context);
              return Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 32, right: 32, top: 73),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 48,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    t.strings.myFavCard,
                                    style: GoogleFonts.poppins().copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 34),
                          ItemHeader(
                            item: item,
                            clickAble: false,
                            noOfLikedCards: 0,
                          ),
                          const SizedBox(height: 27),
                          //TODO: need to implement strings translating functions
                          Text(
                            "${t.strings.peopleWhoLike} ${item.name}",
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFBE94C6)),
                          ),
                          const SizedBox(height: 21),
                          FansList(fans: (state is Data) ? (state.fans) : []),
                        ]),
                  ),
                  if (state is Data)
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //TODO: need to implement strings translating functions
                                Text(
                                  "Add ${item.name} to your fav card interest",
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    if (state.isAlreadyLiked == false &&
                                        noOfLikedFavCards >= 20)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              t.strings.exceededFavCardLimit),
                                        ))
                                      }
                                    else if (state.isAlreadyLiked)
                                      {
                                        itemDetailCubit.unLikeFavCard(
                                            favCardId: item.id, state: state)
                                      }
                                    else
                                      {
                                        context.router
                                            .push(ItemCommentRoute(item: item))
                                      }
                                  },
                                  child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: ShapeDecoration(
                                        shape: const OvalBorder(),
                                        gradient: LinearGradient(
                                          colors: [
                                            state.isAlreadyLiked
                                                ? const Color(0xB2BE94C6)
                                                : Colors.grey,
                                            state.isAlreadyLiked
                                                ? const Color(0xB2BE94C6)
                                                : Colors.grey,
                                            state.isAlreadyLiked
                                                ? const Color(0xB27BC6CC)
                                                : Colors.grey,
                                          ],
                                        )),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          "assets/fav_card/fav_card.svg",
                                          width: 22,
                                          height: 22,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                ],
              );
            }),
      ),
    );
  }
}
