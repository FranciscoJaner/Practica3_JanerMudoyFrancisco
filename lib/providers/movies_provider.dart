import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = "api.themoviedb.org";
  String _apiKey = "7d9318a8e3f1287cc16c0fc2ef39b67f";
  String _language = "es-ES";
  String _page = "1";

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopulars = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print("Movies provider inicialitzat");
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print("getOnDisplayMovies");
    var url = Uri.https(_baseUrl, "3/movie/now_playing",
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnPopulars() async {
    var url = Uri.http(_baseUrl, "3/movie/popular",
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final nowPlayingRespone = NowPlayingResponse.fromJson(result.body);
    onDisplayPopulars = nowPlayingRespone.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print("Demana info al servidor!");
    var url = Uri.http(_baseUrl, "3/movie/$idMovie/credits",
        {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditResponse = CreditsResponse.fromJson(result.body);
    casting[idMovie] = creditResponse.cast;

    return creditResponse.cast;
  }
}
