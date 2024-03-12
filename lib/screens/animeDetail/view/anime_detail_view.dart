import 'package:anime_list/core/di/injection.dart';
import 'package:anime_list/screens/animeDetail/bloc/anime_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeDetailView extends StatelessWidget {
  const AnimeDetailView({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    var bloc = locator.get<AnimeDetailBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime App'),
      ),
      body: _body(context, bloc),
    );
  }

  Widget _body(BuildContext context, AnimeDetailBloc bloc) => BlocBuilder<AnimeDetailBloc, AnimeDetailState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ErrorAnimalState) {
            return _errorNewsState(state.error);
          } else if (state is AnimeInitial) {
            bloc.add(GetAnimeDetail(id));
            return _loadingNewsState();
          } else if (state is NoAnimalState) {
            return _noNewsState();
          } else if (state is AnimeDatasState) {
            return Text(state.animes.data?[0].character?.name ?? "");
            //return _articles(context, state.animes.data);
          }

          return Container();
        },
      );

/*   Widget _articles(context, List<AnimeDetailData?>? animes) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: MediaQuery.of(context).size.height / 1.9),
        itemCount: animes?.length,
        itemBuilder: (context, index) => AnimeListWidget(
          animes: animes?[index],
          onTap: () {},
        ),
      ); */

  Widget _errorNewsState(String error) => Center(
        child: Text(error),
      );

  Widget _noNewsState() => const Center(
        child: Text('No news available'),
      );

  Widget _loadingNewsState() => const Center(
        child: CircularProgressIndicator(),
      );
}
