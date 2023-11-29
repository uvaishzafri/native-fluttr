part of 'fav_card_search_cubit.dart';

@freezed
class FavCardSearchState with _$FavCardSearchState {
  const factory FavCardSearchState.empty() = Empty;

  const factory FavCardSearchState.loading() = Loading;

  const factory FavCardSearchState.error({required AppException appException}) =
      Error;

  const factory FavCardSearchState.success(
      {required List<FavCardItemModel> items}) = Success;
}
