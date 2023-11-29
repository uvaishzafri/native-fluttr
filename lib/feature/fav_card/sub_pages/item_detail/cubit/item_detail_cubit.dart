import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/feature/fav_card/models/fan_model.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'item_detail_cubit.freezed.dart';

part 'item_detail_state.dart';

@lazySingleton
class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit(this._userRepository)
      : super(const ItemDetailState.initial());

  final UserRepository _userRepository;

  void getData({required String favCardId}) async {
    emit(const ItemDetailState.loading());

    var itemDetails = await _userRepository.getItemDetail(id: favCardId);

    itemDetails.fold(
        (left) => emit(ItemDetailState.error(appException: left)),
        (right) => emit(ItemDetailState.data(
            fans: right.fans, isAlreadyLiked: right.isAlreadyLiked)));
  }

  void unLikeFavCard({required String favCardId, required Data state}) async {
    emit(const ItemDetailState.loading());

    var result = await _userRepository.unLikeFavCard(id: favCardId);

    result.fold(
        (left) => emit(ItemDetailState.error(appException: left)),
        (right) => emit(
            ItemDetailState.data(fans: state.fans, isAlreadyLiked: false)));
  }
}
