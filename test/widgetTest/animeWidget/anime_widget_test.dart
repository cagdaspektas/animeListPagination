import 'package:anime_list/core/di/injection.dart';
import 'package:anime_list/screens/anime/bloc/anime_bloc.dart';
import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:anime_list/screens/anime/view/anime_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

import '../../mocks/anime_repo_mocks.dart';

void main() {
  late MockAnimeBloc mockBloc;

  setUp(() async {
    mockBloc = MockAnimeBloc();
    await configureDependencies();
  });
  setUpAll(() {
    registerFallbackValue(AnimeStateFake());
    registerFallbackValue(AnimeEventFake());
  });

  tearDown(() => resetMocktailState());

  List<AnimeList?> generateMockAnimeList(int count) {
    return List.generate(
      count,
      (index) => AnimeList(
        title: 'Anime $index',
        malId: index,
        images: DatumImages(jpg: Jpg(imageUrl: "https://cdn.myanimelist.net/images/anime/1792/138022.jpg")),
        score: 8.0,
        genres: [Demographic(name: "anime")],
        synopsis: 'Synopsis for Anime $index',
        episodes: 12,
      ),
    );
  }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AnimeBloc>(
      create: (context) => mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  var data = generateMockAnimeList(4);

  final oneData = AnimeList(
    title: 'Anime 10',
    malId: 10,
    images: DatumImages(jpg: Jpg(imageUrl: "https://cdn.myanimelist.net/images/anime/1792/138022.jpg")),
    score: 8.0,
    genres: [Demographic(name: "anime")],
    synopsis: 'Synopsis for Anime 10',
    episodes: 12,
  );

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (widgetTester) async {
      when(() => mockBloc.state).thenReturn(AnimeInitial());

      await widgetTester.pumpWidget(_makeTestableWidget(const AnimeView()));
      expect(find.text('Anime App'), findsOneWidget);

      // yükleniyor mu?
      expect(find.byType(Shimmer), findsOneWidget);
    },
  );
  testWidgets(
    ' state is NoAnimalState',
    (widgetTester) async {
      when(() => mockBloc.state).thenReturn(NoAnimalState());

      await widgetTester.pumpWidget(_makeTestableWidget(const AnimeView()));

      await widgetTester.pump(const Duration(seconds: 2));

      expect(find.textContaining("No animal available"), findsOneWidget);
    },
  );

  testWidgets(
    'state is ErrorAnimalState',
    (widgetTester) async {
      when(() => mockBloc.state).thenReturn(const ErrorAnimalState("error"));

      await widgetTester.pumpWidget(_makeTestableWidget(const AnimeView()));

      expect(find.textContaining("error"), findsOneWidget);
    },
  );

  testWidgets(
    ' state is AnimeDatasState',
    (widgetTester) async {
      when(() => mockBloc.state).thenReturn(AnimeDatasState(Anime(data: data)));

      await widgetTester.pumpWidget(_makeTestableWidget(const AnimeView()));
      expect(find.byKey(const Key("gridValue")), findsOneWidget);
    },
  );
}
