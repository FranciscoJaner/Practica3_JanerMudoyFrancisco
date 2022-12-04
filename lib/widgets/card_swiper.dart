import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

// Aquesta clase es la part on es veu las peliculas que hi ha a la cartelera.
class CardSwiper extends StatelessWidget {
  // Cream una llista de Movie, per poder recibirla desde el home_screen y poder utilizar la seva informació.
  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Si la llergaria de la llista no conte res ens mostrara aquest widget.
    if (movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
        width: double.infinity,
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return GestureDetector(
              // Quan clickem pasarem a la ruta details el valor de la Movie que hem clickat.
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    // Si no existeix la foto de la pelicula es mostrara aquesta per defecte.
                    placeholder: AssetImage('assets/no-image.jpg'),
                    // Mostram las peliculas de las fotos.
                    image: NetworkImage(movie.fullPosterPath),
                    fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}
