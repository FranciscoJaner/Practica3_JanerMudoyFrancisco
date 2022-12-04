import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Variable que contindra la instancia del provider MoviesProvider
    final moviesProvider = Provider.of<MoviesProvider>(context);

    // print(moviesProvider.onDisplayMovies);
    // Aquest widget Scaffols sera avon pasarem tota la infromacio de las llistas, per aixi poder emplearo a las altres clases. Apart sera tambe el primer que vourem, que son una mescla de dos widgets diferents.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchMovies(moviesProvider
                        .onDisplayMovies)); // Ens obrira un cercador, per poder Cercar la pelicula que volguem.
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(
                  movies: moviesProvider
                      .onDisplayMovies), // Pasam al CardSwiper la llista de peliculas a traves del provider

              // Slider de pel·licules
              MovieSlider(
                  movies: moviesProvider
                      .onDisplayPopular), // Pasam al MovieSlider la llista de peliculas populars a traves del provider
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
