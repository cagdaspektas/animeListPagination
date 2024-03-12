import 'dart:convert';

import 'package:anime_list/core/constants/api_constants.dart';
import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class HelperAnimeService {
  Future<Anime> fetchAnimes(String page);
}

@Injectable(as: HelperAnimeService)
class AnimeService extends HelperAnimeService {
  static const platform = MethodChannel('com.example.anime/methodChannel');

  @override
  Future<Anime> fetchAnimes(String page) async {
    try {
      final String result = await platform.invokeMethod('fetchAnimeList', ServicePathEnum.anime.rawValue(page: page));
      final Anime animeData = Anime.fromJson(jsonDecode(result));
      return animeData;
    } on PlatformException catch (e) {
      print("Failed to fetch anime list: '${e.message}'.");
      return Anime();
    }
  }
}
