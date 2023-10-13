import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/di/di.dart';
import 'package:native/model/auth_result.dart';
import 'package:native/theme/theme.dart';
import 'package:native/theme/theme_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

@lazySingleton
class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(AppState(theme: ThemeModel.initial())) {
    // Pretend initialization
    // Future.delayed(const Duration(milliseconds: 10),
    //     () => {changeStoryListType(type: StoryListType.top)});
    // changeStoryListType(type: StoryListType.top);
    // checkAuth();
  }

  // final FirebaseAuth _firebaseAuth;

  Future<bool> _getStoreOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skippedOnBoarding') ?? false;
  }

  Future<String?> _getStoreUserIdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userIdToken');
  }

  checkAuth() async {
    bool isSkipped = await _getStoreOnboardInfo();
    String? idToken = await _getStoreUserIdToken();

    if (idToken != null) {
      emit(AppState.loggedIn(
          isSkipped,
          const AuthResult(
            name: "DEMO",
            isExpired: false,
            expiry: 10000,
          )));
      return;
    }
    // _firebaseAuth.
    // emit(state.copyWith(
    //   hasSkippedOnboarding: isSkipped
    //   ));

    emit(AppState.loggedOut(isSkipped));
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
    final primaryColor = ElevationOverlay.colorWithOverlay(
        colorScheme.surface, colorScheme.primary, 3);

    SystemChrome.setSystemUIOverlayStyle(
      createOverlayStyle(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
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
