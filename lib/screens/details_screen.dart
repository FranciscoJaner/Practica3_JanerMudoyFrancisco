import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

// Clase principal que contindra els altres widgets que mostraran la informacio detallada de cada pelicula.
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recoim els arguments que ens pasa el MovieSlider y el CardSwiper y els ficam dintre de la variable peli.
    final Movie peli = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            movie: peli,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Widget que monstra la palt de adalt de la pagina details a partir dels elements que hem pasat
                _PosterAndTitile(
                  movie: peli,
                ),
                // Widget que ens monstra el resum de la peli.
                _Overview(
                  movie: peli,
                ),
                // Widget que monstra els actors que han participat en la pelicula a traves de la id de la pelicula.
                CastingCards(peli.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget que ens monstra una espcie de appbar que conte la peli perque no ens surti una appBar com a tal.
class _CustomAppBar extends StatelessWidget {
  final Movie movie; // Objecte movie per recoir el que ens pasen.

  const _CustomAppBar({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          // Li pasam la foto del objecte Movie que ens han pasat.
          image: NetworkImage(movie.fullPosterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Widget que en mostra el titol, subtitol y titol original de la pelicula.
class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie
                  .fullPosterPath), // Indicam que la foto que ens mostri sigui la del Objecte que ens han pasat
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                movie.title, // Mostram el titol de la pelicula.
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle, // Monstram el titol original.
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  // Mostram las votacions que ha tengut la pelicula.
                  Text(movie.voteAverage.toString(), style: textTheme.caption),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

// Wisget que crea un container amb el resum de la pelicula,
class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie
            .overview, // Indicam que el texte que ha de sortir al container sigui l'overview de la pelicula.
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
