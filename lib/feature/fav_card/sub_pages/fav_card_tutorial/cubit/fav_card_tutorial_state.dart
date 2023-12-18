part of 'fav_card_tutorial_cubit.dart';

@freezed
class FavCardTutorialState with _$FavCardTutorialState {
  const factory FavCardTutorialState.initial() = Initial;

  const factory FavCardTutorialState.loading() = Loading;

  const factory FavCardTutorialState.error({required AppException appException}) = Error;

  const factory FavCardTutorialState.success({required FavCardTutorialModel tutorialModel}) = Success;
}
