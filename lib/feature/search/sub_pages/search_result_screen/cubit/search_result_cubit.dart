import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/feature/search/models/filter_model.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'search_result_cubit.freezed.dart';

part 'search_result_state.dart';

@lazySingleton
class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit(this._userRepository) : super(SearchResultState.filter(filterModel: FilterModel.defaultValues()));

  final UserRepository _userRepository;
  FilterModel filterModel = FilterModel.defaultValues();

  void initialize({required FilterModel filterModel}) {
    this.filterModel = filterModel;
  }

  void removeReligion({required String religion}) {
    List<String> selectedReligions = filterModel.selectedReligions.toList();

    if (selectedReligions.contains(religion)) {
      selectedReligions.remove(religion);
    }
    filterModel = filterModel.copyWith(selectedReligions: selectedReligions);
    getResult();
    emit(Filter(filterModel: filterModel));
  }

  void removeLanguage({required String language}) {
    List<String> selectedLanguages = filterModel.selectedLanguages.toList();

    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    }
    filterModel = filterModel.copyWith(selectedLanguages: selectedLanguages);
    getResult();
    emit(Filter(filterModel: filterModel));
  }

  void removeAgeRange() {
    filterModel = filterModel.copyWith(minMaxAge: []);
    getResult();
    emit(Filter(filterModel: filterModel));
  }

  void removeNativeType({required String nativeType}) {
    List<String> selectedNativeTypes = filterModel.selectedNativeTypes.toList();

    if (selectedNativeTypes.contains(nativeType)) {
      selectedNativeTypes.remove(nativeType);
    }
    filterModel = filterModel.copyWith(selectedNativeTypes: selectedNativeTypes);
    getResult();
    emit(Filter(filterModel: filterModel));
  }

  void removeEnergyRange() {
    filterModel = filterModel.copyWith(minMaxNativeEnergy: []);
    getResult();
    emit(Filter(filterModel: filterModel));
  }

  void removeNeed({required String key}) {
    Map<String, String> needs = Map.of(filterModel.needs);

    if (needs[key] != '0%') {
      needs[key] = '0%';
      filterModel = filterModel.copyWith(needs: needs);
      getResult();
      emit(Filter(filterModel: filterModel));
    }
  }

  void resetFilters() {
    filterModel = FilterModel.defaultValues();
    getResult();
    emit(Filter(filterModel: filterModel));
  }

  Future<void> getResult() async {
    emit(SearchResultState.loading(filterModel: filterModel));
    var response = await _userRepository.getSearchResults(filter: filterModel);

    response.fold((left) => emit(SearchResultState.error(filterModel: filterModel, appException: left)),
        (right) => {filterModel = filterModel.copyWith(users: right), emit(Filter(filterModel: filterModel))});
  }
}
