import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native/feature/top_story/bloc/top_story_cubit.dart';
import 'package:native/model/stories_model.dart';
import 'package:native/repo/hackernews_repository.dart';
import 'package:native/repo/model/story.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockHackNewsRepository extends Mock implements HackNewsRepository {}

class MockStory extends Mock implements Story {}

Story genStory(int id) => Story(
      id: id,
      score: id,
      time: DateTime.now(),
      title: 'Test',
      type: 'story',
      url: '',
      text: 'Test',
    );

void main() {
  group('TopStoryCubit', () {
    late HackNewsRepository hackNewsRepository;

    setUp(() {
      hackNewsRepository = MockHackNewsRepository();
      when(() => hackNewsRepository.topStories()).thenAnswer((_) async =>
          Future.value(Right(List<int>.generate(
              StoriesModel.maxItems, (int index) => index + 1,
              growable: true))));
      when(() => hackNewsRepository.story(any<int>())).thenAnswer(
          (t) async => Right(genStory(t.positionalArguments[0] as int)));
    });

    test(
      'initial state is correct',
      () {
        final topStoryCubit = TopStoryCubit(hackNewsRepository, Logger());
        expect(topStoryCubit.state, const TopStoryState.initial());
      },
    );

    group('next', () {
      blocTest<TopStoryCubit, TopStoryState>('emits [loaded] when calling next',
          build: () => TopStoryCubit(hackNewsRepository, Logger()),
          act: (cubit) => cubit.next(),
          expect: () => {
                isA<TopStoryLoadedState>(),
              },
          verify: (_) {
            verify(() => hackNewsRepository.story(any())).called(19);
          });
    });
  });
}
