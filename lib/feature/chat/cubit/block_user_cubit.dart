import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/repo/firestore_repository.dart';
import 'package:native/util/exceptions.dart';

part 'block_user_state.dart';
part 'block_user_cubit.freezed.dart';

@lazySingleton
class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit(this._firestoreRepository) : super(BlockUserState.initial());

  final FirestoreRepository _firestoreRepository;

  blockUser(String chatRoomDocId) async {
    emit(const BlockUserState.loading());

    var notificationsList = await _firestoreRepository.markChatRoomBlocked(chatRoomDocId);
    notificationsList.fold(
      (left) => emit(BlockUserState.errorState(appException: left)),
      (right) => emit(BlockUserState.successState()),
    );
  }
}
