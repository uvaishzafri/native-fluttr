import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/feature/fav_card/models/fav_card_items/fav_card_items.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'fav_card_search_cubit.freezed.dart';

part 'fav_card_search_state.dart';

@lazySingleton
class FavCardSearchCubit extends Cubit<FavCardSearchState> {
  FavCardSearchCubit(this._userRepository)
      : super(const FavCardSearchState.empty());

  final UserRepository _userRepository;

  void getSearchResults({required String query}) async {
    if (query.isEmpty) {
      emit(const FavCardSearchState.empty());
      return;
    }
    emit(const FavCardSearchState.loading());

    var items = await _userRepository.getFavCardSearchResults(query: query);

    items.fold((left) => emit(FavCardSearchState.error(appException: left)),
        (right) => emit(FavCardSearchState.success(items: right)));
  }
}
