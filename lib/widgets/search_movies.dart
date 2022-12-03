import 'package:flutter/material.dart';

import '../models/models.dart';

class SearchMovies extends SearchDelegate {
  final List<Movie> movies;
  List<Movie> _filtro = [];

  SearchMovies(this.movies);

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
            for (int i = 0; i < _filtro.length; i++) {
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
