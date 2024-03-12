import 'package:anime_list/core/di/injection.dart';
import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:anime_list/screens/animeDetail/view/anime_detail_view.dart';
import 'package:flutter/material.dart';

/* class AnimeView extends StatefulWidget {
  const AnimeView({Key? key}) : super(key: key);

  @override
  State<AnimeView> createState() => _AnimeViewState();
}

class _AnimeViewState extends State<AnimeView> {
  late final HelperAnimeRepository? animeRepository;

  @override
  void initState() {
    super.initState();
    animeRepository = locator.get<HelperAnimeRepository>();
  }

  //final _bloc = di<AnimeBloc>();
  @override
  Widget build(BuildContext context) {
    animeRepository?.fetchAnimesService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime App'),
      ),
      body: const Scaffold(),
    );
  }
} */

import 'package:anime_list/product/widgets/anime_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/anime_bloc.dart';

class AnimeView extends StatelessWidget {
  const AnimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = locator.get<AnimeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime App'),
      ),
      body: _body(context, bloc),
    );
  }

  Widget _body(BuildContext context, AnimeBloc bloc) => BlocBuilder<AnimeBloc, AnimeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ErrorAnimalState) {
            return _errorNewsState(state.error);
          } else if (state is AnimeInitial) {
            bloc.add(GetAnimeDatas());
            return _loadingNewsState();
          } else if (state is NoAnimalState) {
            return _noNewsState();
          } else if (state is AnimeDatasState) {
            return _articles(context, state.animes.data, bloc);
          } else if (state is AnimeDataPagination) {
            return _articles(context, state.animeList, bloc);
          }

          return Container();
        },
      );

  Widget _articles(context, List<AnimeList?>? animes, AnimeBloc bloc) => GridView.builder(
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
              MaterialPageRoute(builder: (context) => AnimeDetailView(id: animes?[index]?.malId.toString() ?? "")),
            );
          },
        ),
      );

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
