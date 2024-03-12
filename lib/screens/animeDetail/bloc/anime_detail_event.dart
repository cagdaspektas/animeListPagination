part of 'anime_detail_bloc.dart';

abstract class AnimeDetailEvent extends Equatable {
  const AnimeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetAnimeDetail extends AnimeDetailEvent {
  final String id;
  const GetAnimeDetail(this.id);
  @override
  List<String> get props => [id];
}
