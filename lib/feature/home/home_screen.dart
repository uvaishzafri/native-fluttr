import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/home/bloc/home_cubit.dart';
import 'package:native/feature/home/home_scaffold.dart';
import 'package:native/model/native.dart';
import 'package:native/widget/native_card.dart';
import 'package:native/widget/text.dart';

const _assetFolder = 'assets/home';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: BlocConsumer<HomeCubit, HomeState>(
          buildWhen: (p, c) => p != c,
          builder: (context, state) {
            final bloc = BlocProvider.of<HomeCubit>(context);

            return HomeScaffold(Container(
              child: Column(children: [
                _searchBar(),
                const SizedBox(height: 13),
                _nativeCard(),
                const SizedBox(height: 13),
                _recommendations(),
              ]),
            ));
          },
          listener: (BuildContext context, HomeState state) {}),
    );
  }

  Widget _searchBar() {
    return NativeTextField(_searchController,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E)));
  }

  Widget _nativeCard() {
    return ExpandableNativeCard(
        native: Native(
            user: "Sarah",
            type: NativeType.field(),
            energy: 33,
            goodFits: [
          NativeType.field(),
          NativeType.field(),
          NativeType.field()
        ]));
  }

  Widget _recommendations() {
    return Column(children: [
      Row(
        children: [
          // NativeUserCard(
          //   native: Native(
          //       user: "Sarah",
          //       type: NativeType.field(),
          //       energy: 33,
          //       goodFits: [
          //         NativeType.field(),
          //         NativeType.field(),
          //         NativeType.field()
          //       ]),
          //   userImage: Image.asset("$_assetFolder/ic_test.png"),
          // ),
          // NativeUserCard(
          //   native: Native(
          //       user: "Sarah",
          //       type: NativeType.field(),
          //       energy: 33,
          //       goodFits: [
          //         NativeType.field(),
          //         NativeType.field(),
          //         NativeType.field()
          //       ]),
          //   userImage: Image.asset("$_assetFolder/ic_test.png"),
          // )
        ],
      )
    ]);
  }

  // Widget _recommendations() {
  //   return GridView.builder(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: 6,
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //       crossAxisCount: 2,
  //     ),
  //     itemBuilder: (context, index) {
  //       return NativeUserCard(
  //         native: Native(
  //             user: "Sarah",
  //             type: NativeType.field(),
  //             energy: 33,
  //             goodFits: [
  //               NativeType.field(),
  //               NativeType.field(),
  //               NativeType.field()
  //             ]),
  //         userImage: Image.asset("$_assetFolder/ic_test.png"),
  //       );
  //     },
  //   );
  // }
}
