part of 'search_result_cubit.dart';

@freezed
class SearchResultState with _$SearchResultState {
  const factory SearchResultState.filter({required FilterModel filterModel}) = Filter;

  const factory SearchResultState.loading({required FilterModel filterModel}) = Loading;

  const factory SearchResultState.error({required FilterModel filterModel, required AppException appException}) = Error;
}
