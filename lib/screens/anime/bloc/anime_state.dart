part of 'anime_bloc.dart';

enum AnimeStatus { animeInitial, animeDatasState, animeDataPagination, noAnimalState, errorAnimalState }

/* abstract class AnimeState extends Equatable {
  const AnimeState();

  @override
  List<Object> get props => [];
} */

class AnimeState extends Equatable {
  final List<AnimeList?>? animeList;
  final Anime? animes;
  final AnimeStatus status;
  final String? error;

  const AnimeState(
      {this.error, this.animeList = const <AnimeList>[], this.animes, this.status = AnimeStatus.animeInitial});

  AnimeState copyWith({
    List<AnimeList?>? animeList,
    Anime? animes,
    AnimeStatus? status,
    String? error,
  }) {
    return AnimeState(
      error: error ?? this.error,
      animeList: animeList ?? this.animeList,
      animes: animes ?? this.animes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [animes, animeList, status, error];
}
/* class AnimeInitial extends AnimeState {
  @override
  List<Object> get props => [];
}

class AnimeDatasState extends AnimeState {
  final Anime animes;

  const AnimeDatasState(this.animes);

  @override
  List<Object> get props => [animes];
}

class AnimeDataPagination extends AnimeState {
  final List<AnimeList?> animeList;

  const AnimeDataPagination(this.animeList);

  @override
  List<List<AnimeList?>> get props => [animeList];
}

class NoAnimalState extends AnimeState {
  @override
  List<Object> get props => [];
}

class ErrorAnimalState extends AnimeState {
  final String error;

  const ErrorAnimalState(this.error);

  @override
  List<Object> get props => [error];
}
 */