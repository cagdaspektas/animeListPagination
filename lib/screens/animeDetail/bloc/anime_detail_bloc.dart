import 'package:anime_list/repositories/anime_detail_repo.dart';
import 'package:anime_list/screens/animeDetail/model/anime_detail_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'anime_detail_event.dart';
part 'anime_detail_state.dart';

@Injectable()
class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  final HelperAnimeDetailRepository? animeRepository;

  AnimeDetailBloc({required this.animeRepository}) : super(AnimeInitial()) {
    on<GetAnimeDetail>((event, emit) async {
      await _getAnimeDetail(event, emit);
    });
  }

  Future<void> _getAnimeDetail(GetAnimeDetail event, Emitter<AnimeDetailState> emit) async {
    AnimeDetail? animesDetail;

    try {
      animesDetail = await animeRepository?.fetchAnimeDetailService(event.id);

      if (animesDetail != null) {
        if (animesDetail.data!.isNotEmpty) {
          emit(AnimeDatasState(animesDetail));
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
