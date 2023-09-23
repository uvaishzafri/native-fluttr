import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/repo/firebase_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseRepository, this._logger)
      : super(const AuthState.initial());

  final FirebaseRepository _firebaseRepository;
  final Logger _logger;

  inputPincode() {
    emit(const AuthState.inputPincode());
  }

  erorrPincode() {
    emit(const AuthState.errorPincode());
  }

  inputEmail() {
    emit(const AuthState.inputEmail());
  }

  initial() {
    emit(const AuthState.initial());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // return super.close();
    return Future.value();
  }
}
