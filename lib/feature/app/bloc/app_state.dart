part of 'app_cubit.dart';

enum StoryListType { top, news, best }

@freezed
class AppState with _$AppState {
  const factory AppState({
    required ThemeModel theme,
    @Default(false) bool hasSkippedOnboarding,
    AuthResult? authResult,
    bool? loggedOut,
  }) = _AppState;

  factory AppState.initial() => _AppState(
        theme: getIt<ThemeModel>(),
        hasSkippedOnboarding: false,
      );

  factory AppState.loggedIn(bool hasSkippedOnboarding, AuthResult authResult) =>
      _AppState(theme: getIt<ThemeModel>(), hasSkippedOnboarding: hasSkippedOnboarding, authResult: authResult);

  factory AppState.loggedOut(bool hasSkippedOnboarding) => _AppState(
        theme: getIt<ThemeModel>(),
        hasSkippedOnboarding: hasSkippedOnboarding,
        loggedOut: true,
      );
}
