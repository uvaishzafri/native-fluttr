import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/dummy_data.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/home/bloc/home_cubit.dart';
import 'package:native/feature/home/home_scaffold.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/user.dart';
import 'package:native/widget/like_overlay.dart';
import 'package:native/widget/native_card.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const _assetFolder = 'assets/home';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _searchController;
  User? _user;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initUser();
      setState(() {});
    });
  }

  initUser() async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('user');
    if (user != null) {
      _user = User.fromJson(jsonDecode(user));
    }
  }

  @override
  void dispose() {
    _searchController?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..fetchRecommendations(),
      child: BlocConsumer<HomeCubit, HomeState>(
          buildWhen: (p, c) => p != c,
          builder: (context, state) {
            final bloc = BlocProvider.of<HomeCubit>(context);

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 100,
                  centerTitle: true,
                  title: SvgPicture.asset('assets/home/ic_logo_black.svg'),
                ),
                body: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      sliver: SliverToBoxAdapter(
                        child: _searchBar(),
                      ),
                    ),
                    // _searchBar(),
                    // const SizedBox(height: 13),
                    SliverPadding(padding: EdgeInsets.all(12), sliver: SliverToBoxAdapter(child: _nativeCard())),
                    // const SizedBox(height: 13),
                    if (state is HomeSuccessState)
                      SliverPadding(padding: EdgeInsets.all(12), sliver: _recommendations(state.users, bloc)),
                  ],
                ),
              ),
            );

          },
          listener: (BuildContext context, HomeState state) {
            state.map(
              initial: (value) {},
              loading: (value) {
                if (!context.loaderOverlay.visible) {
                  context.loaderOverlay.show();
                }
              },
              error: (value) {},
              success: (value) {},
              requestMatchSuccess: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Like Sent')));
              },
            );
          }),
    );
  }

  Widget _searchBar() {
    return NativeTextField(_searchController,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E)));
  }

  Widget _nativeCard() {
    return _user != null
        ? ExpandableNativeCard(
            native: _user!,
          )
        : SizedBox();
  }

  Widget _recommendations(List<User> users, HomeCubit bloc) {
    return SliverGrid.builder(
      // padding: const EdgeInsets.all(8),
      itemCount: users.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        // childAspectRatio: 0.6,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            var overlayItem = LikeOverlay(
              onPressedLike: () {
                bloc.requestMatch(users[index].uid!);
              },
            );
            context.router.push(NativeCardScaffold(user: users[index], overlayItem: overlayItem));
          },
          child: NativeUserCard(
            native: users[index],
          ),
        );
      },
    );
  }
}
