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
  FavCardCubit(this._userRepository) : super(const FavCardState.loading()) {
    getFavCardData();
  }

  final UserRepository _userRepository;

  void getFavCardData() async {
    emit(const FavCardState.loading());

    List<FavCardItemModel> celebs = await _userRepository.getFavCardItems();

    bool hasCompletedFavCardOnBoarding = await _userRepository.hasCompletedFavCardOnBoarding();

    //TODO: Implement error handling
    emit(FavCardState.data(
        items: celebs, selectedCategory: favCardCategories[0], hasCompletedFavCardOnBoarding: hasCompletedFavCardOnBoarding));
  }

  void addRemoveCategory({required FavCardCategoryModel category, required List<FavCardItemModel> items, required bool
  hasCompletedFavCardOnBoarding}) async {
    emit(FavCardState.data(items: items, selectedCategory: category, hasCompletedFavCardOnBoarding: hasCompletedFavCardOnBoarding));
  }
}
