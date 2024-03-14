import 'package:anime_list/repositories/anime_repo.dart';
import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/anime_repo_mocks.dart';

void main() {
  late AnimeRepository animeRepository;
  late MockAnimeService mockAnimeService;

  setUp(() {
    mockAnimeService = MockAnimeService();
    animeRepository = AnimeRepository(mockAnimeService);
  });

  tearDown(() {
    resetMocktailState();
  });

  test("Check If the return type is anime class and not null ", () async {
    when(() => mockAnimeService.fetchAnimes("1")).thenAnswer((_) async {
      return Anime(data: [
        AnimeList(images: DatumImages(jpg: Jpg(imageUrl: "https://cdn.myanimelist.net/images/anime/1792/138022.jpg")))
      ]);
    });

    final result = await animeRepository.fetchAnimesService('1');
    expect(result, isNotNull);
    expect(result, isA<Anime>());
  });
}
