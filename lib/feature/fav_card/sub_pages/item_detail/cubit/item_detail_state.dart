part of 'item_detail_cubit.dart';

@freezed
class ItemDetailState with _$ItemDetailState {
  const factory ItemDetailState.initial() = Initial;

  const factory ItemDetailState.loading() = Loading;

  const factory ItemDetailState.error({required AppException appException}) =
      Error;

  const factory ItemDetailState.data(
      {required List<FanModel> fans, required bool isAlreadyLiked}) = Data;
}
