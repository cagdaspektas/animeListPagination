import 'package:anime_list/core/di/injection.dart';
import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:anime_list/screens/animeDetail/view/anime_detail_view.dart';
import 'package:flutter/material.dart';

import 'package:anime_list/product/widgets/anime_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/anime_bloc.dart';

class AnimeView extends StatelessWidget {
  const AnimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = locator.get<AnimeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime App'),
        centerTitle: true,
      ),
      body: _body(context, bloc),
    );
  }

  Widget _body(BuildContext context, AnimeBloc bloc) => BlocBuilder<AnimeBloc, AnimeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.status == AnimeStatus.errorAnimalState) {
            return _errorAnimalState(state.error ?? "");
          } else if (state.status == AnimeStatus.animeInitial) {
            bloc.add(GetAnimeDatas());
            return _loadingAnimalState(context);
          } else if (state.status == AnimeStatus.noAnimalState) {
            return _noAnimalState();
          } else if (state.status == AnimeStatus.animeDatasState) {
            return _animes(context, state.animes?.data, bloc);
          } else if (state.status == AnimeStatus.animeDataPagination) {
            return _animes(context, state.animeList, bloc);
          }

          return const SizedBox();
        },
      );

  Widget _animes(context, List<AnimeList?>? animes, AnimeBloc bloc) {
    return GridView.builder(
      controller: bloc.scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: MediaQuery.of(context).size.height / 1.9),
      itemCount: animes?.length,
      itemBuilder: (context, index) => AnimeListWidget(
        animes: animes?[index],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimeDetailView(
                      id: animes?[index]?.malId.toString() ?? "",
                      image: animes?[index]?.images?.jpg?.imageUrl ?? "",
                      rating: animes?[index]?.score ?? 0.0,
                      title: animes?[index]?.title ?? "",
                      genre: animes?[index]?.genres,
                      synopsis: animes?[index]?.synopsis ?? "",
                      episodes: animes?[index]?.episodes ?? 0,
                    )),
          );
        },
      ),
    );
  }

  Widget _errorAnimalState(String error) => Center(
        child: Text(error),
      );

  Widget _noAnimalState() => const Center(
        child: Text('No news available'),
      );

  Widget _loadingAnimalState(BuildContext context) => Shimmer.fromColors(
        baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
        period: const Duration(seconds: 1),
        direction: ShimmerDirection.ltr,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: MediaQuery.of(context).size.height / 1.9),
          itemBuilder: (context, index) {
            return Card(
              child: Column(),
            );
          },
          itemCount: 3,
        ),
      );
}
