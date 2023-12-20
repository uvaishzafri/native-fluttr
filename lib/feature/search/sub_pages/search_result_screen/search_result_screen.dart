import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/search/models/filter_model.dart';
import 'package:native/feature/search/sub_pages/search_result_screen/cubit/search_result_cubit.dart';
import 'package:native/feature/search/widgets/filter_chips.dart';
import 'package:native/i18n/translations.g.dart';
import 'package:native/widget/like_dialog.dart';
import 'package:native/widget/like_overlay.dart';
import 'package:native/widget/native_card.dart';

@RoutePage()
class SearchResultScreen extends StatelessWidget {
  final FilterModel filterModel;

  const SearchResultScreen({super.key, required this.filterModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
            child: SingleChildScrollView(
              child: Column(children: [
                BlocProvider<SearchResultCubit>.value(
                  value: getIt<SearchResultCubit>()
                    ..initialize(filterModel: filterModel)
                    ..getResult(),
                  child: BlocConsumer<SearchResultCubit, SearchResultState>(
                      bloc: getIt<SearchResultCubit>(),
                      listener: (context, state) {
                        state.map(
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
                          filter: (value) {
                            if (context.loaderOverlay.visible) {
                              context.loaderOverlay.hide();
                            }
                          },
                        );
                      },
                      buildWhen: (p, c) => p != c && c is Filter,
                      builder: (context, state) {
                        SearchResultCubit cubit = BlocProvider.of<SearchResultCubit>(context);

                        FilterModel filterModel = state.filterModel;
                        List<String> selectedReligions = filterModel.selectedReligions;
                        List<String> selectedLanguages = filterModel.selectedLanguages;
                        List<String> selectedNativeTypes = filterModel.selectedNativeTypes;

                        return Column(children: <Widget>[
                          SizedBox(
                            height: 48,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () => Navigator.of(context).pop(filterModel),
                                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    t.strings.searchResult,
                                    style: GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 41),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(t.strings.searchResult,
                                  style: GoogleFonts.poppins().copyWith(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14)),
                              GestureDetector(
                                onTap: () => cubit.resetFilters(),
                                child: Text(
                                  t.strings.reset,
                                  style: GoogleFonts.poppins().copyWith(
                                      color: const Color(0xFFBE94C6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(0xFFBE94C6),
                                      shadows: [const Shadow(color: Colors.white, offset: Offset(0, -5))]),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(alignment: WrapAlignment.start, direction: Axis.horizontal, runSpacing: 10, children: [
                            for (int i = 0; i < selectedReligions.length; i++)
                              FilterChips(
                                item: selectedReligions[i],
                                onPressed: () => cubit.removeReligion(religion: selectedReligions[i]),
                              ),
                            for (int i = 0; i < selectedNativeTypes.length; i++)
                              FilterChips(
                                item: selectedNativeTypes[i],
                                onPressed: () => cubit.removeNativeType(nativeType: selectedNativeTypes[i]),
                              ),
                            for (int i = 0; i < selectedLanguages.length; i++)
                              FilterChips(
                                item: selectedLanguages[i],
                                onPressed: () => cubit.removeLanguage(language: selectedLanguages[i]),
                              ),
                            if (state.filterModel.minMaxAge.length > 1)
                              FilterChips(
                                  item: "${t.strings.age} ${state.filterModel.minMaxAge.first} - ${state.filterModel.minMaxAge.last}",
                                  onPressed: () => cubit.removeAgeRange()),
                            if (state.filterModel.minMaxNativeEnergy.length > 1)
                              FilterChips(
                                  item:
                                      "${t.strings.energy} ${state.filterModel.minMaxNativeEnergy.first} - ${state.filterModel.minMaxNativeEnergy.last}",
                                  onPressed: () => cubit.removeEnergyRange()),
                            for (var need in state.filterModel.needs.entries)
                              FilterChips(item: "${need.key} ${need.value}", onPressed: () => cubit.removeNeed(key: need.key))
                          ]),
                          GridView.count(
                            shrinkWrap: true,
                            childAspectRatio: 0.55,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            scrollDirection: Axis.vertical,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: List.generate(
                              state.filterModel.users.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () async {
                                    var overlayItem = LikeOverlay(
                                      onPressedLike: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => const LikeDialog(),
                                        );
                                      },
                                      isTutorial: false,
                                    );
                                    context.router.push(NativeCardScaffold(
                                        user: state.filterModel.users[index], overlayItem: overlayItem, isDemoUser: true));
                                  },
                                  child: NativeUserCard(
                                    native: state.filterModel.users[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ]);
                      }),
                ),
              ]),
            )));
  }
}
