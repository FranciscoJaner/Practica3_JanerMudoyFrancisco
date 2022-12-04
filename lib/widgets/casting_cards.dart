import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';

// Clase la cual ens monstrara el diferents actors que surten a una pelicula.
class CastingCards extends StatelessWidget {
  final int idMovie;

  const CastingCards(this.idMovie);
  @override
  Widget build(BuildContext context) {
    // Añadim el provider per podera accedir al metode que ens retorna el future.
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(idMovie),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        // Si snapshot no te informacio ens tornara un container per defecte.
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final casting = snapshot.data!; // Ficam a la variable les dades.
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
                itemCount: casting
                    .length, // Indicam que la llergaria sera igual a les dades que tenim ja que sino pot donar error.
                scrollDirection: Axis.horizontal,
                // Pasam les dades al widget CastCard.
                itemBuilder: (BuildContext context, int index) => _CastCard(
                      cast: casting[index],
                    )),
          );
        }
      },
    );
  }
}

// Widget que sera el que contendra tant las imatges noms y altres.
class _CastCard extends StatelessWidget {
  final Cast cast;

  const _CastCard({required this.cast});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              // Si aquest actor no te foto es monstrara aquesta imatge per defecte.
              placeholder: AssetImage('assets/no-image.jpg'),
              // Indicam que es monstrin las fotos de els actors.
              image: NetworkImage(cast.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // Indicam que es monstri el noms dels actors.
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
