// To parse this JSON data, do
//
//     final nowPopular = nowPopularFromMap(jsonString);

import 'models.dart';

class NowPopular {
  NowPopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory NowPopular.fromJson(String str) =>
      NowPopular.fromMap(json.decode(str));

  factory NowPopular.fromMap(Map<String, dynamic> json) => NowPopular(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
