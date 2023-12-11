import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/cubit/fav_card_tutorial_cubit.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/widgets/slider_page.dart';
import 'package:native/i18n/translations.g.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/gradient_text.dart';

import '../../../../../di/di.dart';

@RoutePage()
class FavCardTutorialSliderScreen extends StatefulWidget {
  const FavCardTutorialSliderScreen({super.key});

  @override
  State<FavCardTutorialSliderScreen> createState() => _FavCardTutorialSliderScreenState();
}

class _FavCardTutorialSliderScreenState extends State<FavCardTutorialSliderScreen> {
  PageController pageController = PageController();
  static const lastIndex = 4;

  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
      child: BlocProvider<FavCardTutorialCubit>.value(
          value: getIt<FavCardTutorialCubit>(),
          child: BlocBuilder<FavCardTutorialCubit, FavCardTutorialState>(builder: (context, state) {
            final favCardTutorialCubit = BlocProvider.of<FavCardTutorialCubit>(context);
            return Stack(
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 48,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close_outlined),
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
                  Flexible(
                    child: PageView(
                        onPageChanged: (int page) {
                          setState(() {
                            currentIndex = page;
                            if (currentIndex == lastIndex) {
                              favCardTutorialCubit.markTutorialCompletion();
                            }
                          });
                        },
                        controller: pageController,
                        children: [
                          SliderPage(
                              imageAddress: "assets/fav_card/tutorial_slide_one.png",
                              title: t.strings.fav_card_tutorial_one_title,
                              index: 1),
                          SliderPage(
                              imageAddress: "assets/fav_card/tutorial_slide_two.png",
                              title: t.strings.fav_card_tutorial_two_title,
                              index: 2),
                          SliderPage(
                              imageAddress: "assets/fav_card/tutorial_slide_three.png",
                              title: t.strings.fav_card_tutorial_three_title,
                              index: 3),
                          SliderPage(
                              imageAddress: "assets/fav_card/tutorial_slide_four.png",
                              title: t.strings.fav_card_tutorial_four_title,
                              index: 4),
                          SliderPage(
                              imageAddress: "assets/fav_card/tutorial_slide_five.png",
                              title: t.strings.fav_card_tutorial_five_title,
                              index: 5),
                        ]),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(bottom: 17),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (currentIndex != 0)
                          Flexible(
                            child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [Color(0xB2BE94C6), Color(0xB27BC6CC)]),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    height: 54.0,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x19616161),
                                          offset: Offset(10, 10),
                                          blurRadius: 10.0,
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.transparent,
                                        disabledForegroundColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        disabledBackgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (pageController.hasClients) {
                                          pageController.animateToPage(
                                            pageController.page!.floor() - 1,
                                            duration: const Duration(milliseconds: 400),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      child: GradientText(
                                        'Back',
                                        style:
                                            GoogleFonts.poppins().copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                                        gradient: const LinearGradient(colors: [Color(0xB2BE94C6), Color(0xB27BC6CC)]),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        if (currentIndex == 0) const Spacer(),
                        const SizedBox(width: 20),
                        Flexible(
                          child: NativeButton(
                            isEnabled: true,
                            text: currentIndex == lastIndex ? t.strings.done : t.strings.next,
                            onPressed: () {
                              if (pageController.hasClients) {
                                pageController.animateToPage(
                                  pageController.page!.floor() + 1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if (currentIndex == lastIndex) {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          })),
    ));
  }
}
