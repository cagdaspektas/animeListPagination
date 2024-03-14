import 'package:anime_list/core/di/injection.dart';
import 'package:anime_list/screens/animeDetail/bloc/anime_detail_bloc.dart';
import 'package:anime_list/screens/animeDetail/model/anime_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/widgets/rating_widget.dart';
import '../../anime/model/anime_model.dart';

class AnimeDetailView extends StatelessWidget {
  const AnimeDetailView(
      {super.key,
      required this.id,
      required this.title,
      required this.rating,
      required this.image,
      required this.genre,
      required this.synopsis,
      required this.episodes});
  final String id;
  final String title;
  final String synopsis;
  final int episodes;

  final double rating;
  final String image;
  final List<Demographic>? genre;

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
            return _articles(context, state.animes);
          }

          return Container();
        },
      );
  Widget _articles(BuildContext context, AnimeDetail? anime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              image,
            ),
            Text(
              title,
              key: Key('title $id'),
              style: const TextStyle(fontSize: 24, color: Colors.red),
            ),
            RatingWidget(
              score: rating.toString(),
            ),
            const SizedBox(
              height: 1,
            ),
            _episodes(),
            Text(
              synopsis,
              style: const TextStyle(fontSize: 16),
            ),
            _genresList(),
            _characterList(context, anime)
          ],
        ),
      ),
    );
  }

  _episodes() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Episodes:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(episodes.toString()),
        ],
      ),
    );
  }

  ExpansionTile _characterList(BuildContext context, AnimeDetail? anime) {
    return ExpansionTile(
      title: const Text("List Of Characters"),
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: MediaQuery.of(context).size.height / 1.9),
          itemCount: anime?.data?.length,
          itemBuilder: (BuildContext context, int index) {
            return _characterDetail(anime, index);
          },
        ),
      ],
    );
  }

  Expanded _characterDetail(AnimeDetail? anime, int index) {
    return Expanded(
      child: Column(
        children: [
          Image.network(
            anime?.data?[index].character?.images?.jpg?.imageUrl ?? "",
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            anime?.data?[index].character?.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  ExpansionTile _genresList() {
    return ExpansionTile(title: const Text("Genres"), children: [
      ListView.builder(
        itemCount: genre?.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(genre?[index].name.toString() ?? ""),
          );
        },
      ),
    ]);
  }

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
