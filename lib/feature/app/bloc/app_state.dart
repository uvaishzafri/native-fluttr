part of 'app_cubit.dart';

enum StoryListType { top, news, best }

@freezed
class AppState with _$AppState {
  const factory AppState({
    required ThemeModel theme,
    @Default(false) bool hasSkippedOnboarding,
    @Default(false) bool hasCompletedTutorial,
    @Default(false) bool hasVerifiedEmail,
    AuthResult? authResult,
    bool? loggedOut,
  }) = _AppState;

  factory AppState.initial() => _AppState(
        theme: getIt<ThemeModel>(),
        hasSkippedOnboarding: false,
      );

  factory AppState.loggedIn(bool hasSkippedOnboarding,
          bool hasCompletedTutorial, AuthResult authResult) =>
      _AppState(
        theme: getIt<ThemeModel>(),
        hasSkippedOnboarding: hasSkippedOnboarding,
        authResult: authResult,
        hasCompletedTutorial: hasCompletedTutorial,
      );

  factory AppState.loggedOut(bool hasSkippedOnboarding,
          bool hasCompletedTutorial, bool isVerifiedEmail) =>
      _AppState(
        theme: getIt<ThemeModel>(),
        hasSkippedOnboarding: hasSkippedOnboarding,
        hasCompletedTutorial: hasCompletedTutorial,
        loggedOut: true,
        hasVerifiedEmail: isVerifiedEmail,
      );
}
