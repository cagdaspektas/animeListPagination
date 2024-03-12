// To parse this JSON data, do
//
//     final animeDetail = animeDetailFromJson(jsonString);

import 'dart:convert';

AnimeDetail animeDetailFromJson(String str) => AnimeDetail.fromJson(json.decode(str));

class AnimeDetail {
  List<AnimeDetailData>? data;

  AnimeDetail({
    this.data,
  });

  factory AnimeDetail.fromJson(Map<String, dynamic> json) => AnimeDetail(
        data: List<AnimeDetailData>.from(json["data"].map((x) => AnimeDetailData.fromJson(x))),
      );
}

class AnimeDetailData {
  AnimeDetailCharacter? character;
  String? role;
  int? favorites;
  List<VoiceActor>? voiceActors;

  AnimeDetailData({
    this.character,
    this.role,
    this.favorites,
    this.voiceActors,
  });

  factory AnimeDetailData.fromJson(Map<String, dynamic> json) => AnimeDetailData(
        character: AnimeDetailCharacter.fromJson(json["character"]),
        role: json["role"],
        favorites: json["favorites"],
        voiceActors: List<VoiceActor>.from(json["voice_actors"].map((x) => VoiceActor.fromJson(x))),
      );
}

class AnimeDetailCharacter {
  int? malId;
  String? url;
  CharacterImages? images;
  String? name;

  AnimeDetailCharacter({
    this.malId,
    this.url,
    this.images,
    this.name,
  });

  factory AnimeDetailCharacter.fromJson(Map<String, dynamic> json) => AnimeDetailCharacter(
        malId: json["mal_id"],
        url: json["url"],
        images: CharacterImages.fromJson(json["images"]),
        name: json["name"],
      );
}

class CharacterImages {
  PurpleJpg? jpg;
  AnimeDetailWebp? webp;

  CharacterImages({
    this.jpg,
    this.webp,
  });

  factory CharacterImages.fromJson(Map<String, dynamic> json) => CharacterImages(
        jpg: PurpleJpg.fromJson(json["jpg"]),
        webp: AnimeDetailWebp.fromJson(json["webp"]),
      );
}

class PurpleJpg {
  String? imageUrl;

  PurpleJpg({
    this.imageUrl,
  });

  factory PurpleJpg.fromJson(Map<String, dynamic> json) => PurpleJpg(
        imageUrl: json["image_url"],
      );
}

class AnimeDetailWebp {
  String? imageUrl;
  String? smallImageUrl;

  AnimeDetailWebp({
    this.imageUrl,
    this.smallImageUrl,
  });

  factory AnimeDetailWebp.fromJson(Map<String, dynamic> json) => AnimeDetailWebp(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
      );
}

class VoiceActor {
  Person? person;
  String? language;

  VoiceActor({
    this.person,
    this.language,
  });

  factory VoiceActor.fromJson(Map<String, dynamic> json) => VoiceActor(
        person: Person.fromJson(json["person"]),
        language: json["language"],
      );
}

class Person {
  int? malId;
  String? url;
  PersonImages? images;
  String? name;

  Person({
    this.malId,
    this.url,
    this.images,
    this.name,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        malId: json["mal_id"],
        url: json["url"],
        images: PersonImages.fromJson(json["images"]),
        name: json["name"],
      );
}

class PersonImages {
  FluffyJpg? jpg;

  PersonImages({
    this.jpg,
  });

  factory PersonImages.fromJson(Map<String, dynamic> json) => PersonImages(
        jpg: FluffyJpg.fromJson(json["jpg"]),
      );
}

class FluffyJpg {
  String? imageUrl;

  FluffyJpg({
    this.imageUrl,
  });

  factory FluffyJpg.fromJson(Map<String, dynamic> json) => FluffyJpg(
        imageUrl: json["image_url"],
      );
}
