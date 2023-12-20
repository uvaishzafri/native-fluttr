import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/search/cubit/search_cubit.dart';
import 'package:native/feature/search/models/filter_model.dart';
import 'package:native/feature/search/widgets/needs_filter.dart';
import 'package:native/i18n/translations.g.dart';
import 'package:native/model/native_type.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/native_negative_button.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/widget/thumb_icon.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CommonFilters extends StatelessWidget {
  final bool hasActiveSubscription;

  const CommonFilters({super.key, required this.hasActiveSubscription});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>.value(
        value: getIt<SearchCubit>(),
        child: BlocBuilder<SearchCubit, SearchState>(
            bloc: getIt<SearchCubit>(),
            builder: (context, state) {
              if (state is Filter) {
                SearchCubit cubit = BlocProvider.of<SearchCubit>(context);

                FilterModel filterModel = state.filterModel;

                List<String> selectedReligions = filterModel.selectedReligions;
                List<String> selectedLanguages = filterModel.selectedLanguages;
                List<String> selectedNativeTypes = filterModel.selectedNativeTypes;

                TextEditingController rangeStartController =
                    TextEditingController(text: filterModel.minMaxAge.isNotEmpty ? filterModel.minMaxAge[0].toStringAsFixed(0) : "25");
                TextEditingController rangeEndController =
                    TextEditingController(text: filterModel.minMaxAge.isNotEmpty ? filterModel.minMaxAge[1].toStringAsFixed(0) : "30");
                TextEditingController energyRangeStartController = TextEditingController(
                    text: filterModel.minMaxNativeEnergy.isNotEmpty ? filterModel.minMaxNativeEnergy[0].toStringAsFixed(0) : "12");
                TextEditingController energyRangeEndController = TextEditingController(
                    text: filterModel.minMaxNativeEnergy.isNotEmpty ? filterModel.minMaxNativeEnergy[1].toStringAsFixed(0) : "20");

                SfRangeValues minMaxAge = SfRangeValues(filterModel.minMaxAge.isNotEmpty ? filterModel.minMaxAge[0] : 25,
                    filterModel.minMaxAge.isNotEmpty ? filterModel.minMaxAge[1] : 30);
                SfRangeValues minMaxEnergy = SfRangeValues(
                    filterModel.minMaxNativeEnergy.isNotEmpty ? filterModel.minMaxNativeEnergy[0] : 12,
                    filterModel.minMaxNativeEnergy.isNotEmpty ? filterModel.minMaxNativeEnergy[1] : 20);

                return Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          NativeSmallBodyText(t.strings.religion),
                          const SizedBox(height: 12),
                          NativeDropdown(
                            onChanged: (value) {
                              cubit.updateReligions(religions: value);
                            },
                            value: selectedReligions,
                            maxItems: 3,
                            textStyle: NativeMediumBodyText.getStyle(context),
                            items: religions.keys
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: NativeMediumBodyText(item),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 26),
                          NativeSmallBodyText(t.strings.language),
                          const SizedBox(height: 12),
                          NativeDropdown(
                            onChanged: (value) {
                              cubit.updateLanguages(languages: value);
                            },
                            value: selectedLanguages,
                            maxItems: 3,
                            textStyle: NativeMediumBodyText.getStyle(context),
                            items: languages
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: NativeMediumBodyText(item),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 26),
                          NativeSmallBodyText(t.strings.ageRange),
                          const SizedBox(height: 12),
                          SfRangeSliderTheme(
                            data: SfRangeSliderThemeData(
                              activeTrackColor: ColorUtils.aquaGreen,
                            ),
                            child: SfRangeSlider(
                              min: 18,
                              max: 50,
                              stepSize: 1,
                              startThumbIcon: ThumbIcon(controller: rangeStartController),
                              endThumbIcon: ThumbIcon(controller: rangeEndController),
                              showLabels: true,
                              values: minMaxAge,
                              onChangeStart: (SfRangeValues newValues) {
                                rangeStartController.text = newValues.start.toInt().toString();
                                rangeEndController.text = newValues.end.toInt().toString();
                              },
                              onChanged: (SfRangeValues newValues) {
                                cubit.updateAgeRange(minMaxAge: newValues);
                                //set state here
                                rangeStartController.text = newValues.start.toInt().toString();
                                rangeEndController.text = newValues.end.toInt().toString();
                                minMaxAge = newValues;
                              },
                            ),
                          ),
                          if (hasActiveSubscription)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 26),
                                NativeSmallBodyText(t.strings.nativeType),
                                const SizedBox(height: 12),
                                NativeDropdown(
                                  onChanged: (value) {
                                    cubit.updateNativeTypes(nativeTypes: value);
                                  },
                                  value: selectedNativeTypes,
                                  maxItems: 3,
                                  textStyle: NativeMediumBodyText.getStyle(context),
                                  items: NativeTypeEnum.values
                                      .map((item) => DropdownMenuItem(
                                            value: item.toString().split('.').last.capitalize,
                                            child: NativeMediumBodyText(item.toString().split('.').last.capitalize),
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(height: 26),
                                NativeSmallBodyText(t.strings.nativeEnergy),
                                const SizedBox(height: 12),
                                SfRangeSliderTheme(
                                  data: SfRangeSliderThemeData(
                                    activeTrackColor: ColorUtils.aquaGreen,
                                  ),
                                  child: SfRangeSlider(
                                    min: 3,
                                    max: 36,
                                    stepSize: 1,
                                    startThumbIcon: ThumbIcon(controller: energyRangeStartController),
                                    endThumbIcon: ThumbIcon(controller: energyRangeEndController),
                                    showLabels: true,
                                    values: minMaxEnergy,
                                    onChangeStart: (SfRangeValues newValues) {
                                      energyRangeStartController.text = newValues.start.toInt().toString();
                                      energyRangeEndController.text = newValues.end.toInt().toString();
                                    },
                                    onChanged: (SfRangeValues newValues) {
                                      cubit.updateEnergyRange(minMaxEnergy: newValues);
                                      //set state here
                                      energyRangeStartController.text = newValues.start.toInt().toString();
                                      energyRangeEndController.text = newValues.end.toInt().toString();
                                      minMaxEnergy = newValues;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  t.strings.nativeEnergyFilterMessage,
                                  style: GoogleFonts.poppins().copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),
                                ),
                                const SizedBox(height: 19),
                                NativeSmallBodyText(t.strings.needParameter),
                                NeedsFilter(needs: state.filterModel.needs),
                                const SizedBox(height: 200),
                              ],
                            ),
                        ]),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30, top: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                  child: NativeNegativeButton(
                                isEnabled: true,
                                text: t.strings.reset,
                                onPressed: () => cubit.resetFilters(),
                              )),
                              const Spacer(),
                              Flexible(
                                child: NativeButton(
                                  isEnabled: true,
                                  text: t.strings.apply,
                                  onPressed: () async {
                                    FilterModel result =
                                        await context.router.push(SearchResultRoute(filterModel: filterModel)) as FilterModel;
                                    cubit.updateFilter(filterModel: result);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            }));
  }
}
