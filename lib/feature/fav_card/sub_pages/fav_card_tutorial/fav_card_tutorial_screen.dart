import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/cubit/fav_card_tutorial_cubit.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/models/fav_card_tutorial_item_model.dart';
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
          value: getIt<FavCardTutorialCubit>()..getTutorialData(),
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
                return SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                    const SizedBox(height: 20),
                    if (state is Success)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.tutorialModel.title,
                            style:
                                GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFFBE94C6)),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: ListView.separated(
                              itemCount: state.tutorialModel.steps.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                FavCardTutorialItemModel tutorial = state.tutorialModel.steps[index];
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          tutorial.stepIconImageAddress,
                                          width: tutorial.stepIconImageWidth,
                                          height: tutorial.stepIconImageHeight,
                                        ),
                                        const SizedBox(width: 15),
                                        Flexible(
                                          child: Text(
                                            tutorial.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.visible,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Image.network(
                                      tutorial.stepContentImageAddress,
                                      width: tutorial.stepContentImageWidth,
                                      height: tutorial.stepContentImageHeight,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18, top: 10),
                      child: GestureDetector(
                        onTap: () => {},
                        child: SizedBox(
                          height: 50,
                          child: Stack(
                            children: [
                              Stack(children: [
                                Stack(
                                  children: [
                                    Image.asset("assets/fav_card/what_fav_card_background.png", fit: BoxFit.fill, width: double.infinity),
                                    Positioned.fill(
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Container(
                                          decoration: ShapeDecoration(
                                              color: Colors.black.withOpacity(0.9),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              t.strings.whatFavCardShort.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins().copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 2,
                                                  height: 2),
                                            ),
                                            Text(
                                              "${t.strings.learnMore} >>",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins().copyWith(
                                                color: Colors.transparent,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 2,
                                                height: 22 / 8,
                                                decoration: TextDecoration.underline,
                                                decorationColor: Colors.white,
                                                decorationThickness: 2,
                                                shadows: [const Shadow(color: Colors.white, offset: Offset(0, -5))],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ])
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                );
              }),
        ),
      ),
    );
  }
}
