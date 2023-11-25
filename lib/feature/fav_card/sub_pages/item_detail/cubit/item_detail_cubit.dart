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
  ItemDetailCubit(this._userRepository) : super(const ItemDetailState.initial());

  final UserRepository _userRepository;

  void getData({required String favCardId}) async {
    emit(const ItemDetailState.loading());

    List<FanModel> fans = await _userRepository.getFavCardFanData(id: favCardId);

    bool isAlreadyLiked = await _userRepository.isFavCardAlreadyLiked(id: favCardId);

    //TODO Implement error handling
    emit(ItemDetailState.data(fans: fans, isAlreadyLiked: isAlreadyLiked));
  }

  void unLikeFavCard({required String favCardId, required Data state}) async {
    emit(const ItemDetailState.loading());

    //TODO Implement error handling
    void result = await _userRepository.unLikeFavCard(id: favCardId);
    emit(ItemDetailState.data(fans: state.fans, isAlreadyLiked: false));
  }
}
