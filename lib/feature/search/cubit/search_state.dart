part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.filter({required FilterModel filterModel}) = Filter;
}
