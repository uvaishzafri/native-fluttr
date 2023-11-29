import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/cubit/fav_card_tutorial_cubit.dart';
import 'package:native/i18n/translations.g.dart';

@RoutePage()
class FavCardTutorialScreen extends StatelessWidget {
  const FavCardTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
        child: BlocProvider<FavCardTutorialCubit>.value(
          value: getIt<FavCardTutorialCubit>(),
          child: BlocConsumer<FavCardTutorialCubit, FavCardTutorialState>(
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
                      backgroundColor: const Color(0xFFFF0000),
                    ));
                  },
                  success: (value) {
                    if (context.loaderOverlay.visible) {
                      context.loaderOverlay.hide();
                    }
                  },
                );
              },
              buildWhen: (p, c) => p != c && (c is Success || c is Initial),
              builder: (context, state) {
                final favCardTutorialCubit = BlocProvider.of<FavCardTutorialCubit>(context);
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
                            t.strings.myFavCard,
                            style: GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
              }),
        ),
      ),
    );
  }
}
