part of 'fav_card_cubit.dart';

@freezed
class FavCardState with _$FavCardState {
  const factory FavCardState.initial() = Initial;

  const factory FavCardState.loading() = Loading;

  const factory FavCardState.error({required AppException appException}) =
      Error;

  const factory FavCardState.data(
      {required List<FavCardItemModel> items,
      required FavCardCategoryModel selectedCategory,
      required bool hasCompletedFavCardOnBoarding,
      required int noOfLikedFavCards}) = Data;
}
