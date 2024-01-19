// ignore_for_file: non_constant_identifier_names

class MovieDetailModel {
  final String overview, homepage;
  final int id, runtime;
  final double vote_average;
  final List<String> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : overview = json['overview'],
        homepage = json['homepage'],
        id = json['id'] as int,
        runtime = json['runtime'] as int,
        vote_average = json['vote_average'] as double,
        genres = (json['genres'] as List)
            .map((item) => item['name'] as String)
            .toList();

  @override
  String toString() {
    return 'MovieDetailModel{id: $id, overview: $overview, genres: $genres} homepage: $homepage, runtime: $runtime';
  }
}
