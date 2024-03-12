import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../repositories/anime_repo.dart';
import '../model/anime_model.dart';

part 'anime_event.dart';
part 'anime_state.dart';

@Injectable()
class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final HelperAnimeRepository? animeRepository;
  Anime? animes;
  List<AnimeList?>? animeList = [];
  ScrollController scrollController = ScrollController();
  int page = 1;

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent) &&
        animes?.pagination?.hasNextPage != false) {
      add(PaginationDatas());
    }
  }

  AnimeBloc({required this.animeRepository}) : super(AnimeInitial()) {
    on<GetAnimeDatas>((event, emit) async {
      await _getAllAnimes(event, emit);
    });
    on<PaginationDatas>((event, emit) async {
      await _getPaginationAnimes(event, emit);
    });
  }

  Future<void> _getAllAnimes(_, Emitter<AnimeState> emit) async {
    try {
      animes = await animeRepository?.fetchAnimesService(page.toString());

      if (animes != null) {
        if (animes!.data!.isNotEmpty) {
          scrollController.addListener(pagination);
          animeList?.addAll(animes!.data!);
          emit(AnimeDatasState(animes!));
        } else {
          emit(NoAnimalState());
        }
      } else {
        emit(const ErrorAnimalState("There is an error about animes wait for a moment and try again later"));
      }
    } catch (error) {
      emit(ErrorAnimalState(error.toString()));
    }
  }

  Future<void> _getPaginationAnimes(_, Emitter<AnimeState> emit) async {
    try {
      page += 1;
      animes = await animeRepository?.fetchAnimesService(page.toString());

      if (animes != null) {
        if (animes!.data!.isNotEmpty) {
          animeList!.addAll(animes!.data!);
          emit(AnimeDataPagination(animeList!));
        } else {
          emit(NoAnimalState());
        }
      } else {
        emit(const ErrorAnimalState("There is an error about animes wait for a moment and try again later"));
      }
    } catch (error) {
      emit(ErrorAnimalState(error.toString()));
    }
  }
}
