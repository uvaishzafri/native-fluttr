import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/models/fav_card_tutorial_model.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'fav_card_tutorial_cubit.freezed.dart';

part 'fav_card_tutorial_state.dart';

@lazySingleton
class FavCardTutorialCubit extends Cubit<FavCardTutorialState> {
  FavCardTutorialCubit(this._userRepository) : super(const FavCardTutorialState.initial());

  final UserRepository _userRepository;

  void getTutorialData() async {
    emit(const FavCardTutorialState.loading());

    var response = await _userRepository.getFavCardTutorialData();

    response.fold(
        (left) => emit(FavCardTutorialState.error(appException: left)), (right) => emit(FavCardTutorialState.success(tutorialModel: right)));
  }

  Future<void> markTutorialCompletion() async {
     await _userRepository.markTutorialCompletion();
  }
}
