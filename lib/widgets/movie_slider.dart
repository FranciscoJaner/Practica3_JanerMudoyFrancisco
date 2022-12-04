import 'package:flutter/material.dart';
import '../models/models.dart';

// Clase la qual ens crea el movie slider a la part de la HomePage.
class MovieSlider extends StatelessWidget {
  // Cream una llista de movies per poder recibirles desde el home page.
  final List<Movie> movies;

  const MovieSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // Indicam que sigui la mateixa que la llista ja que sino pot provocar errors.
                itemCount: movies.length,
                itemBuilder: (_, int index) => _MoviePoster(
                      // Pasam la llista al MoviePoster.
                      movie: movies[index],
                    )),
          )
        ],
      ),
    );
  }
}

//Clase la qual utilizarem per mostrar las imatges de las peliculas y el seu Titol.
class _MoviePoster extends StatelessWidget {
  // Objecte Movie que es el que enviarem a la pagina details.
  final Movie movie;
  const _MoviePoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // Pasam a la pagina details un objecte movie perque ens monstri la informació.
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                // Agafam la imatge de la pelicula.
                image: NetworkImage(movie.fullPosterPath),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // Agafam de la llista de Movie el seu title perque correspongui.
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
