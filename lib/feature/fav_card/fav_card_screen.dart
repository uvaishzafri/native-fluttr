import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/fav_card/cubit/fav_card_cubit.dart';
import 'package:native/feature/fav_card/widgets/catergory_list/fav_card_category_list.dart';
import 'package:native/feature/fav_card/widgets/header.dart';
import 'package:native/feature/fav_card/widgets/items_grid/Items_grid.dart';
import 'package:native/widget/native_text_field.dart';

import '../../i18n/translations.g.dart';
import '../../util/fav_card/fav_card_constants.dart';

@RoutePage()
class FavCardScreen extends StatefulWidget {
  const FavCardScreen({super.key});

  @override
  State<FavCardScreen> createState() => _FavCardScreenState();
}

class _FavCardScreenState extends State<FavCardScreen> {
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavCardCubit>.value(
      value: getIt<FavCardCubit>(),
      child: BlocConsumer<FavCardCubit, FavCardState>(
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
            data: (value) {},
          );
        },
        buildWhen: (p, c) => p != c && c is Data,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(child: Header()),
                        SliverToBoxAdapter(
                            child: _searchBar(
                                noOfLikedCards: (state is Data)
                                    ? (state.noOfLikedFavCards)
                                    : 0)),
                        const SliverToBoxAdapter(child: CategoryList()),
                        SliverToBoxAdapter(
                            child: ItemsGrid(
                          selectedCategory: (state is Data)
                              ? (state.selectedCategory)
                              : popularListModel,
                          items: (state is Data) ? (state.items) : [],
                          noOfLikedFavCards:
                              (state is Data) ? (state.noOfLikedFavCards) : 0,
                          hasCompletedFavCardOnBoarding: (state is Data)
                              ? state.hasCompletedFavCardOnBoarding
                              : false,
                        )),
                        if ((state is Data)
                            ? (state.noOfLikedFavCards < 5)
                            : true)
                          const SliverToBoxAdapter(child: SizedBox(height: 100))
                      ],
                    ),
                  ),
                  if ((state is Data) ? (state.noOfLikedFavCards < 5) : true)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF7BC6CC),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              t.strings.addMoreCards,
                              style: GoogleFonts.poppins().copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _searchBar({required int noOfLikedCards}) {
    return InkWell(
      onTap: () => {
        context.router.push(FavCardSearchRoute(noOfLikedCards: noOfLikedCards)),
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28, top: 36),
        child: IgnorePointer(
          child: NativeTextField(
            _searchController,
            hintText: t.strings.search,
            prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E)),
          ),
        ),
      ),
    );
  }
}
