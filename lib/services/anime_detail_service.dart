import 'dart:convert';

import 'package:anime_list/screens/animeDetail/model/anime_detail_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../core/constants/api_constants.dart';

abstract class HelperAnimeDetailService {
  Future<AnimeDetail> fetchAnimeDetail(String id);
}

@Injectable(as: HelperAnimeDetailService)
class AnimeDetailService extends HelperAnimeDetailService {
  static const platform = MethodChannel('com.example.anime/methodChannel');

  @override
  Future<AnimeDetail> fetchAnimeDetail(String id) async {
    try {
      final String result =
          await platform.invokeMethod('fetchAnimeDetail', ServicePathEnum.animdeDetail.rawValue(id: id));
      final AnimeDetail animeData = AnimeDetail.fromJson(jsonDecode(result));
      return animeData;
    } on PlatformException catch (e) {
      print("Failed to fetch anime list: '${e.message}'.");
      return AnimeDetail();
    }
  }
}
