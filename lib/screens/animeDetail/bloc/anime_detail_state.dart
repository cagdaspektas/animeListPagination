part of 'anime_detail_bloc.dart';

abstract class AnimeDetailState extends Equatable {
  const AnimeDetailState();

  @override
  List<Object> get props => [];
}

class AnimeInitial extends AnimeDetailState {
  @override
  List<Object> get props => [];
}

class AnimeDatasState extends AnimeDetailState {
  final AnimeDetail animes;

  const AnimeDatasState(this.animes);

  @override
  List<Object> get props => [animes];
}

class NoAnimalState extends AnimeDetailState {
  @override
  List<Object> get props => [];
}

class ErrorAnimalState extends AnimeDetailState {
  final String error;

  const ErrorAnimalState(this.error);

  @override
  List<Object> get props => [error];
}
