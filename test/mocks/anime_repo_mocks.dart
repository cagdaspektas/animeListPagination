import 'package:anime_list/repositories/anime_detail_repo.dart';
import 'package:anime_list/repositories/anime_repo.dart';
import 'package:anime_list/screens/anime/bloc/anime_bloc.dart';
import 'package:anime_list/services/anime_detail_service.dart';
import 'package:anime_list/services/anime_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnimeService extends Mock implements AnimeService {}

class MockAnimeRepository extends Mock implements AnimeRepository {}

class MockAnimeDetailRepository extends Mock implements AnimeDetailRepository {}

class MockAnimeDetailService extends Mock implements AnimeDetailService {}

class MockAnimeBloc extends MockBloc<AnimeEvent, AnimeState> implements AnimeBloc {}

class AnimeStateFake extends Fake implements AnimeState {}

class AnimeEventFake extends Fake implements AnimeEvent {}
