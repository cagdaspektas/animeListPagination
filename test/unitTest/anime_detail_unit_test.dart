import 'package:anime_list/repositories/anime_detail_repo.dart';
import 'package:anime_list/screens/animeDetail/model/anime_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/anime_repo_mocks.dart';

void main() {
  late AnimeDetailRepository animeDetailRepository;
  late MockAnimeDetailService mockAnimeDetailService;

  setUp(() {
    mockAnimeDetailService = MockAnimeDetailService();
    animeDetailRepository = AnimeDetailRepository(mockAnimeDetailService);
  });

  tearDown(() {
    resetMocktailState();
  });

  test("Check If the return type is AnimeDetail class and not null ", () async {
    when(() => mockAnimeDetailService.fetchAnimeDetail("1")).thenAnswer((_) async {
      return AnimeDetail(data: [AnimeDetailData(character: AnimeDetailCharacter(malId: 1))]);
    });

    final result = await animeDetailRepository.fetchAnimeDetailService('1');
    expect(result, isNotNull);
    expect(result, isA<AnimeDetail>());
  });
}
