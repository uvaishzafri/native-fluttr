import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_search/cubit/fav_card_search_cubit.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_search/widgets/fav_card_search_empty_state.dart';
import 'package:native/feature/fav_card/sub_pages/widgets/item_header.dart';

import '../../../../di/di.dart';
import '../../../../i18n/translations.g.dart';
import '../../../../widget/native_text_field.dart';

@RoutePage()
class FavCardSearchScreen extends StatefulWidget {
  final int noOfLikedCards;

  const FavCardSearchScreen({super.key, required this.noOfLikedCards});

  @override
  State<FavCardSearchScreen> createState() => _FavCardSearchScreenState();
}

class _FavCardSearchScreenState extends State<FavCardSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
        child: BlocProvider<FavCardSearchCubit>.value(
          value: getIt<FavCardSearchCubit>(),
          child: BlocConsumer<FavCardSearchCubit, FavCardSearchState>(
              listener: (context, state) {
                state.map(
                    empty: (value) {},
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
                        backgroundColor: const Color(0xFFFF0000),
                      ));
                    },
                    success: (value) {
                      if (context.loaderOverlay.visible) {
                        context.loaderOverlay.hide();
                      }
                    });
              },
              buildWhen: (p, c) => p != c && (c is Success || c is Empty),
              builder: (context, state) {
                final favCardSearchCubit = BlocProvider.of<FavCardSearchCubit>(context);
                return Column(children: [
                  SizedBox(
                    height: 48,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            t.strings.searchFavCards,
                            style: GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  NativeTextField(
                    _searchController,
                    hintText: t.strings.search,
                    prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close_outlined, color: Color(0xAF1E1E1E)),
                      onPressed: () {
                        _searchController.text = "";
                        favCardSearchCubit.getSearchResults(query: "");
                      },
                    ),
                    onChanged: (query) {
                      favCardSearchCubit.getSearchResults(query: query);
                    },
                    autoFocus: true,
                  ),
                  if (state is Empty) const Expanded(child: FavCardSearchEmptyState()),
                  const SizedBox(height: 46),
                  if (state is Success)
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemHeader(item: state.items[index], clickAble: true, noOfLikedCards: widget.noOfLikedCards);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 32,
                        ),
                      ),
                    )
                ]);
              }),
        ),
      ),
    );
  }
}
