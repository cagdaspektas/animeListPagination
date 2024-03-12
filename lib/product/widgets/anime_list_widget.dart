import 'package:anime_list/screens/anime/model/anime_model.dart';
import 'package:flutter/material.dart';

class AnimeListWidget extends StatelessWidget {
  final AnimeList? animes;
  final VoidCallback? onTap;
  const AnimeListWidget({super.key, this.animes, this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  animes?.images?.jpg?.imageUrl ?? "",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(animes?.title ?? '', textAlign: TextAlign.center),
              Text(
                animes?.source ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
        ),
      );
}
