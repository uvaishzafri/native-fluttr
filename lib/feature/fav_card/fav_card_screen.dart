import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/fav_card/cubit/fav_card_cubit.dart';
import 'package:native/feature/fav_card/widgets/catergory_list/category_list.dart';
import 'package:native/feature/fav_card/widgets/header.dart';
import 'package:native/feature/fav_card/widgets/items_grid/Items_grid.dart';
import 'package:native/widget/native_text_field.dart';

import '../../i18n/translations.g.dart';

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
        builder: (context, state) {
          if (state is Data) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: Header()),
                      SliverToBoxAdapter(child: _searchBar()),
                      const SliverToBoxAdapter(child: CategoryList()),
                      SliverToBoxAdapter(child: ItemsGrid(selectedCategory: state.selectedCategory, items: state.items)),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28, top: 36),
      child: NativeTextField(_searchController, hintText: t.strings.search, prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E))),
    );
  }
}
