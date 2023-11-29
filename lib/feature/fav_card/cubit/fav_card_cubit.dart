import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/feature/fav_card/models/fav_card_category_model.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

import '../../../util/fav_card/fav_card_constants.dart';
import '../models/fav_card_items/fav_card_items.dart';

part 'fav_card_cubit.freezed.dart';

part 'fav_card_state.dart';

@lazySingleton
class FavCardCubit extends Cubit<FavCardState> {
  FavCardCubit(this._userRepository) : super(const FavCardState.initial()) {
    getFavCardData();
  }

  final UserRepository _userRepository;

  void getFavCardData() async {
    emit(const FavCardState.loading());

    var favCardData = await _userRepository.getFavCardData();

    favCardData.fold(
        (left) => emit(FavCardState.error(appException: left)),
        (right) => emit(FavCardState.data(
            items: right.items,
            selectedCategory: favCardBaseCategories[0],
            hasCompletedFavCardOnBoarding: right.hasCompletedFavCardOnBoarding,
            noOfLikedFavCards: right.noOfLikedFavCards)));
  }

  void addRemoveCategory(
      {required FavCardCategoryModel category,
      required List<FavCardItemModel> items,
      required bool hasCompletedFavCardOnBoarding,
      required int noOfLikedFavCards}) async {
    emit(FavCardState.data(
        items: items,
        selectedCategory: category,
        hasCompletedFavCardOnBoarding: hasCompletedFavCardOnBoarding,
        noOfLikedFavCards: noOfLikedFavCards));
  }
}
