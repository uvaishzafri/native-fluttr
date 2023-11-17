import 'dart:async';
import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/di/di.dart';
import 'package:native/model/auth_result.dart';
import 'package:native/model/user.dart' as user;
import 'package:native/repo/user_repository.dart';
import 'package:native/theme/theme.dart';
import 'package:native/theme/theme_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

@lazySingleton
class AppCubit extends HydratedCubit<AppState> {
  AppCubit(
    this._firebaseAuth,
    this._userRepository,
  ) : super(AppState(theme: ThemeModel.initial())) {
    // Pretend initialization
    // Future.delayed(const Duration(milliseconds: 10),
    //     () => {changeStoryListType(type: StoryListType.top)});
    // changeStoryListType(type: StoryListType.top);
    // checkAuth();
  }

  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  Future<bool> _getStoreOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skippedOnBoarding') ?? false;
  }

  Future<bool> _getTutorialCompletedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tutorialCompleted') ?? false;
  }

  Future<String?> _getStoreUserIdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userIdToken');
  }

  // Future<String?> _getStoredUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('user');
  // }

  Future<user.User?> _getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) {
      return null;
    }
    return user.User.fromJson(jsonDecode(userJson));
  }

  Future<bool> checkIfEmailVerifiedByUid(String uid) async {
    // emit(const AuthState.checkEmailVerification());
    var checkUser = await _userRepository.checkUserEmailVerified(uid);
    if (checkUser.isRight && checkUser.right) {
      // emit(const AuthState.emailVerificationComplete());
      return true;
    }

    return false;
  }

  Future<bool> checkIfEmailVerifiedByRefId(String refId) async {
    // emit(const AuthState.checkEmailVerification());
    var checkUser = await _userRepository.checkEmailRefId(refId);
    if (checkUser.isRight && checkUser.right) {
      // emit(const AuthState.emailVerificationComplete());
      return true;
    }

    return false;
  }

  checkAuth() async {
    bool isSkipped = await _getStoreOnboardInfo();
    bool isTutorialCompleted = await _getTutorialCompletedPref();
    String? idToken = await _getStoreUserIdToken();

    // _firebaseAuth.authStateChanges().listen((user) async {
    //   if (user == null) {
    //     SharedPreferences prefs = await SharedPreferences.getInstance();
    //     prefs.clear();
    //     emit(AppState.loggedOut(isSkipped));
    //   }
    // });

    if (idToken != null) {
      user.User? storedUser = await _getStoredUser();
      if (storedUser != null) {
        if (!(storedUser.emailVerified ?? false)) {
          logout();
          return;
        } else {
          if (storedUser.uid != null) {
            FirebaseCrashlytics.instance.setUserIdentifier(storedUser.uid!);
          }
          emit(
            AppState.loggedIn(
              isSkipped,
              isTutorialCompleted,
              AuthResult(
                user: storedUser,
                isExpired: false,
                expiry: 10000,
              ),
            ),
          );
          return;
        }
      }
    }
    // _firebaseAuth.
    // emit(state.copyWith(
    //   hasSkippedOnboarding: isSkipped
    //   ));

    emit(AppState.loggedOut(isSkipped, isTutorialCompleted, false));
  }

  logout({bool isVerifiedEmail = false}) async {
    emit(AppState.initial());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('userIdToken');
    prefs.remove('userTokenTimestampInSeconds');
    prefs.remove('notificationSettings');
    _firebaseAuth.signOut();
    FirebaseCrashlytics.instance.setUserIdentifier('');

    bool isSkipped = await _getStoreOnboardInfo();
    bool isTutorialCompleted = await _getTutorialCompletedPref();
    emit(AppState.loggedOut(isSkipped, isTutorialCompleted, isVerifiedEmail));
  }

  Future<void> setThemeMode({required ThemeMode mode}) async {
    if (mode == ThemeMode.system) {
      final theme = ThemeModel.initial();
      emit(state.copyWith(theme: theme));
      updateSystemOverlay();
    }

    emit(state.copyWith.theme(mode: mode));
    updateSystemOverlay();
  }

  void updateSystemOverlay() {
    final systemModeIsDark =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

    final isDark = state.theme.mode == ThemeMode.system
        ? systemModeIsDark
        : state.theme.mode == ThemeMode.dark;
    final colorScheme =
        isDark ? state.theme.dark.colorScheme : state.theme.light.colorScheme;
    SystemChrome.setSystemUIOverlayStyle(
      createOverlayStyle(
        brightness: isDark ? Brightness.dark : Brightness.light,
        navColor: colorScheme.primaryContainer,
      ),
    );
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    final theme = ThemeModel.fromJson(json['theme'] as Map<String, dynamic>);

    return AppState(theme: theme);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      'theme': state.theme.toJson(),
    };
  }
}
