import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //Ho feim extends de ChangeNotifier per convertir la clase amb un provider.
  String _baseUrl = "api.themoviedb.org";
  String _apiKey =
      "7d9318a8e3f1287cc16c0fc2ef39b67f"; // Cream unas variables amb tota la informació necessaria per poder realitzar la petició.
  String _language = "es-ES";
  String _page = "1";

// Llistas de Movie que tindra el valors que aconseguim desde la peticio.
  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopular = [];

// Mapa de enters, amb una llista de Cast, que contendra la id de la pelicula y la resta de la informació
  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print("Movies provider inicialitzat");
    this.getOnDisplayMovies();
    this.getOnPopulars();
  }

  // Funcio la cual fa la petició a la api per aconseguir la informació de las peliculas, es fa asincroa ja que es un metode que no sabem quan ens tornara el valor.
  getOnDisplayMovies() async {
    print("getOnDisplayMovies");
    var url = Uri.https(_baseUrl, "3/movie/now_playing", {
      'api_key': _apiKey,
      'language': _language,
      'page': _page
    }); // Feim la peticio per aconseguir els valors que volem.

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(
        url); // Ficam el que ens retorna dins la variable result, la feim await per obligar a declarar el metode a ser asincor.
    final nowPlayingResponse = NowPlayingResponse.fromJson(result
        .body); // Cream una nova variable que guardara un string tipus json.

    onDisplayMovies =
        nowPlayingResponse.results; // Pasam a la llista las movies.

    notifyListeners();
  }

// Metode que realitza el mateix que l'anterior pero per aconseguir las peliculas mes populars.
  getOnPopulars() async {
    print("getOnPopulars");
    var url = Uri.http(_baseUrl, "3/movie/popular",
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final nowPopular = NowPopular.fromJson(result.body);
    onDisplayPopular = nowPopular.results;

    notifyListeners();
  }

// Future que en retorna una llista de cast.
  Future<List<Cast>> getMovieCast(int idMovie) async {
    print("Demana info al servidor!");
    var url = Uri.http(_baseUrl, "3/movie/$idMovie/credits",
        {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditResponse = CreditsResponse.fromJson(result.body);
    // Guardam dintre de el Mapa tots els actors avon la pelicula sigui la id.
    casting[idMovie] = creditResponse.cast;

    return creditResponse.cast;
  }
}
