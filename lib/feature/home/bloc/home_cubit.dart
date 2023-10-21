import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/firebase_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._firebaseRepository, this._logger, this._userRepository)
      : super(const HomeState.initial());

  final FirebaseRepository _firebaseRepository;
  final UserRepository _userRepository;
  final Logger _logger;

  initial() {
    emit(const HomeState.initial());
  }

  fetchRecommendations() async {
    emit(const HomeState.loading());

    var notificationsList = await _userRepository.getRecommendations();
    notificationsList.fold(
      (left) => emit(HomeState.error(appException: left)),
      (right) => emit(HomeState.success(users: right)),
    );
  }

  requestMatch(String userId) async {
    emit(const HomeState.loading());

    var requestRep = await _userRepository.requestMatch(userId);
    requestRep.fold(
      (left) => emit(HomeState.error(appException: left)),
      (right) => emit(HomeState.requestMatchSuccess()),
    );
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // return super.close();
    return Future.value();
  }


}
