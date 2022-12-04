import 'package:flutter/material.dart';

import '../models/models.dart';

// Widget que ens permet cercar una pelicula en concret.
class SearchMovies extends SearchDelegate {
  final List<Movie> movies;
  List<Movie> _filtro = [];

  SearchMovies(this.movies);

// Boto que surt adalt a la dreta que quan clickam borra el que tenim seleccionat.
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = ' ';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

// Boto que tenim a la esquerra que quan el clickam ens torna a la HomePage.
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: (() {
          close(context, null);
        }),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListView.builder(
      itemCount: _filtro.length,
      itemBuilder: ((_, index) => ListTile(
            title: Text(movies[index].title.toString()),
            onTap: (() {
              query = movies[index].title.toString();
            }),
          )),
    );
  }

// Es el que ens mostra devall el TextField las diferents sugerencias de las pelis
  @override
  Widget buildSuggestions(BuildContext context) {
    _filtro = movies.where((element) {
      return element.title.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemCount: _filtro.length,
      itemBuilder: (context, index) {
        final resultat = _filtro[index].title;
        return ListTile(
          title: Text(resultat),
          onTap: () {
            query = resultat;
            // Recorrem l'array que conte las pelis,
            for (int i = 0; i < _filtro.length; i++) {
              // Si el nom que hem introduit esta dins la llista, ficara el nom dintre de una Movie, que despres enviarem a la pantalla details que es la que mos montrara la informacio de la pelicula.
              if (_filtro[i].title == query) {
                Movie resultatfinal = _filtro[i];
                Navigator.pushNamed(context, 'details',
                    arguments: resultatfinal);
              }
            }
          },
        );
      },
    );
  }
}
