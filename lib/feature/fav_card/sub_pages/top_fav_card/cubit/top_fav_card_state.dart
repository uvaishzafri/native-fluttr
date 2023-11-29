part of 'top_fav_card_cubit.dart';

@freezed
class TopFavCardState with _$TopFavCardState {
  const factory TopFavCardState.initial() = Initial;

  const factory TopFavCardState.loading() = Loading;

  const factory TopFavCardState.error({required AppException appException}) =
      Error;

  const factory TopFavCardState.data(
      {required List<FavCardItemModel> favCards}) = Data;

  const factory TopFavCardState.dataUpdated(
      {required List<FavCardItemModel> favCards}) = DataUpdated;
}
