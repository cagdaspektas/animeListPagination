import 'package:anime_list/core/di/injection.dart';
import 'package:anime_list/screens/anime/bloc/anime_bloc.dart';
import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:anime_list/screens/anime/view/anime_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/anime_repo_mocks.dart';

void main() {
  late AnimeBloc mockBloc;

  List<AnimeList?> generateMockAnimeList(int count) {
    // Belirli bir sayıda mock anime listesi oluşturun
    return List.generate(
      count,
      (index) => AnimeList(
        // Her bir anime için gerekli alanları doldurun, bu örnekte rastgele değerler kullanılıyor
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

  setUpAll(() => null);
  setUp(() async {
    await configureDependencies();
    mockBloc = MockAnimeBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  testWidgets("description", (tester) async {
    mockBloc = MockAnimeBloc();
    var data = generateMockAnimeList(5);
    mockBloc.add(GetAnimeDatas());
    await tester.pumpAndSettle(const Duration(seconds: 5));
    when(() => mockBloc.state).thenReturn(AnimeDatasState(Anime(data: data)));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AnimeBloc>.value(
          value: mockBloc,
          child: const AnimeView(),
        ),
      ),
    );

    expect(find.byType(GridView), findsOneWidget);
    await expectLater(find.byType(AnimeView), matchesGoldenFile('main.png'));
  });
}
