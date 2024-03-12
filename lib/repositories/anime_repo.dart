import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:anime_list/services/anime_service.dart';
import 'package:injectable/injectable.dart';

abstract class HelperAnimeRepository {
  Future<Anime> fetchAnimesService(String page);
}

@Singleton(as: HelperAnimeRepository)
class AnimeRepository extends HelperAnimeRepository {
  final HelperAnimeService _animeService;
  AnimeRepository(this._animeService);

  @override
  Future<Anime> fetchAnimesService(String page) async {
    return await _animeService.fetchAnimes(page);
  }
}
