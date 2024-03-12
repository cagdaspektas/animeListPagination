import 'package:anime_list/screens/animeDetail/model/anime_detail_model.dart';
import 'package:anime_list/services/anime_detail_service.dart';
import 'package:injectable/injectable.dart';

abstract class HelperAnimeDetailRepository {
  Future<AnimeDetail> fetchAnimeDetailService(String id);
}

@Singleton(as: HelperAnimeDetailRepository)
class AnimeDetailRepository extends HelperAnimeDetailRepository {
  final HelperAnimeDetailService _animeDetailService;
  AnimeDetailRepository(this._animeDetailService);

  @override
  Future<AnimeDetail> fetchAnimeDetailService(String id) async {
    return await _animeDetailService.fetchAnimeDetail(id);
  }
}
