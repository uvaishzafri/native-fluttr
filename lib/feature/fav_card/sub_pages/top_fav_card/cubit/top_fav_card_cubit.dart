import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/repo/user_repository.dart';

import '../../../../../util/exceptions.dart';
import '../../../models/fav_card_items/fav_card_items.dart';

part 'top_fav_card_cubit.freezed.dart';

part 'top_fav_card_state.dart';

@lazySingleton
class TopFavCardCubit extends Cubit<TopFavCardState> {
  TopFavCardCubit(this._userRepository)
      : super(const TopFavCardState.initial());

  final UserRepository _userRepository;

  void getData() async {
    emit(const TopFavCardState.loading());

    var items = await _userRepository.getTopFavCards();

    items.fold((left) => emit(TopFavCardState.error(appException: left)),
        (right) => emit(TopFavCardState.data(favCards: right)));
  }

  void reorderCards(
      {required Data state, required int oldIndex, required int newIndex}) {
    emit(const TopFavCardState.loading());
    List<FavCardItemModel> favCards = List.from(state.favCards);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    FavCardItemModel item = favCards.removeAt(oldIndex);
    favCards.insert(newIndex, item);
    emit(TopFavCardState.data(favCards: favCards));
  }

  void updateFavCards({required List<FavCardItemModel> favCards}) async {
    emit(const TopFavCardState.loading());

    var result = await _userRepository.updateTopFavCards(favCards: favCards);

    result.fold((left) => emit(TopFavCardState.error(appException: left)),
        (right) => emit(TopFavCardState.dataUpdated(favCards: favCards)));
  }

  void removeFavCard({required FavCardItemModel favCard, required Data state}) {
    emit(const TopFavCardState.loading());
    List<FavCardItemModel> favCards = List.from(state.favCards);
    favCards.removeWhere((element) => element == favCard);

    emit(TopFavCardState.data(favCards: favCards));
  }
}
