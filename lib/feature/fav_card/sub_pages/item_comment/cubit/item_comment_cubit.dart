import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'item_comment_cubit.freezed.dart';

part 'item_comment_state.dart';

@lazySingleton
class ItemCommentCubit extends Cubit<ItemCommentState> {
  ItemCommentCubit(this._userRepository)
      : super(const ItemCommentState.initial());

  final UserRepository _userRepository;

  void likeFavCard({required String favCardId, required String comment}) async {
    emit(const ItemCommentState.loading());

    var response =
        await _userRepository.likeFavCard(id: favCardId, comment: comment);

    response.fold((left) => emit(ItemCommentState.error(appException: left)),
        (right) => emit(const ItemCommentState.success()));
  }
}
