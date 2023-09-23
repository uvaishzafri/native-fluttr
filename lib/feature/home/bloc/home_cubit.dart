import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/repo/firebase_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._firebaseRepository, this._logger)
      : super(const HomeState.initial());

  final FirebaseRepository _firebaseRepository;
  final Logger _logger;

  initial() {
    emit(const HomeState.initial());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // return super.close();
    return Future.value();
  }
}
