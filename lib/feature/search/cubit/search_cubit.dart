import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/feature/search/models/filter_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

part 'search_cubit.freezed.dart';

part 'search_state.dart';

@lazySingleton
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.filter(filterModel: FilterModel.defaultValues()));

  void updateReligions({required List<String> religions}) {
    emit(Filter(filterModel: state.filterModel.copyWith(selectedReligions: religions)));
  }

  void updateLanguages({required List<String> languages}) {
    emit(Filter(filterModel: state.filterModel.copyWith(selectedLanguages: languages)));
  }

  void updateAgeRange({required SfRangeValues minMaxAge}) {
    emit(Filter(filterModel: state.filterModel.copyWith(minMaxAge: [minMaxAge.start.round(), minMaxAge.end.round()])));
  }

  void updateNativeTypes({required List<String> nativeTypes}) {
    emit(Filter(filterModel: state.filterModel.copyWith(selectedNativeTypes: nativeTypes)));
  }

  void updateEnergyRange({required SfRangeValues minMaxEnergy}) {
    emit(Filter(filterModel: state.filterModel.copyWith(minMaxNativeEnergy: [minMaxEnergy.start.round(), minMaxEnergy.end.round()])));
  }

  void updateNeed({required String key, required String value}) {
    Map<String, String> needs = Map.of(state.filterModel.needs);
    needs[key] = value;
    emit(Filter(filterModel: state.filterModel.copyWith(needs: needs)));
  }

  void resetFilters() {
    emit(Filter(filterModel: FilterModel.defaultValues()));
  }

  void updateFilter({required FilterModel filterModel}) {
    emit(Filter(filterModel: filterModel));
  }
}
