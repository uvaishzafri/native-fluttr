import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/feature/fav_card/sub_pages/top_fav_card/cubit/top_fav_card_cubit.dart';
import 'package:native/feature/fav_card/sub_pages/top_fav_card/widgets/top_fav_card_list_item.dart';

import '../../../../di/di.dart';
import '../../../../i18n/translations.g.dart';
import '../../../../widget/native_button.dart';
import '../../models/fav_card_items/fav_card_items.dart';

@RoutePage()
class TopFavCardScreen extends StatelessWidget {
  const TopFavCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int listItemHeight = 90;
    const int numberOfShowAbleCards = 3;
    return BlocProvider<TopFavCardCubit>.value(
        value: getIt<TopFavCardCubit>()..getData(),
        child: BlocConsumer<TopFavCardCubit, TopFavCardState>(
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
                    content: Text(
                      value.appException.message,
                    ),
                  ));
                },
                data: (value) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                },
                dataUpdated: (value) {
                  if (context.loaderOverlay.visible) {
                    context.loaderOverlay.hide();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(t.strings.changeSaved),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.of(context).pop();
                },
              );
            },
            buildWhen: (p, c) => p != c && c is Data,
            builder: (context, state) {
              List<FavCardItemModel> items = [];
              if (state is Data) items = state.favCards;
              final topFavCardCubit = BlocProvider.of<TopFavCardCubit>(context);
              return Scaffold(
                body: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 70, left: 32, right: 32),
                        child: Column(children: [
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
                                  child: Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          'assets/ic_logo_light.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          //TODO: need to implement strings translating functions
                          Text(
                            "Choose your top $numberOfShowAbleCards interests",
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFBE94C6),
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(height: 23),
                          //TODO: need to implement strings translating functions
                          Text(
                            "Your top $numberOfShowAbleCards interests will be shown to others who like you",
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFBE94C6),
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(height: 25),

                          if (state is Data)
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: listItemHeight * items.length + 200,
                                    child: Stack(
                                      children: [
                                        DottedBorder(
                                            child: Container(
                                                height: listItemHeight *
                                                    numberOfShowAbleCards *
                                                    1,
                                                width: double.infinity,
                                                color:
                                                    const Color(0xFFF5F5F5))),
                                        ReorderableListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 200),
                                          children: <Widget>[
                                            for (int index = 0;
                                                index < items.length;
                                                index++)
                                              Column(
                                                key: Key(
                                                    "TopFavCardListItem$index"),
                                                children: [
                                                  TopFavCardListItem(
                                                      item: items[index],
                                                      height: listItemHeight,
                                                      state: state),
                                                  if (index == 2)
                                                    const SizedBox(
                                                      height: 20,
                                                    )
                                                ],
                                              ),
                                          ],
                                          onReorder:
                                              (int oldIndex, int newIndex) {
                                            //We are sure that state will be Data if we are here. Cause in all other states we don't have list to work with
                                            topFavCardCubit.reorderCards(
                                                state: state,
                                                oldIndex: oldIndex,
                                                newIndex: newIndex);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          //const SizedBox(height: 200),
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
                                child: NativeButton(
                                  isEnabled: true,
                                  text: t.strings.save,
                                  onPressed: () => topFavCardCubit
                                      .updateFavCards(favCards: state.favCards),
                                ),
                              ),
                            ))
                    ],
                  ),
                ),
              );
            }));
  }
}
