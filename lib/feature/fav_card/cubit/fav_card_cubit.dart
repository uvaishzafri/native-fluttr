import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/fav_card/fav_card_category.dart';
import 'package:native/model/fav_card/fav_card_items/fav_card_items.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

import '../../../util/fav_card/fav_card_constants.dart';

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

    emit(FavCardState.data(
        items: celebs, selectedCategory: favCardCategories[0]));
  }

  void addRemoveCategory(
      {required FavCardCategoryModel category,
      required List<FavCardItemModel> items}) async {
    emit(FavCardState.data(items: items, selectedCategory: category));
  }
}
