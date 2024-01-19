// ignore_for_file: non_constant_identifier_names

class MovieModel {
  final String poster_path, title;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : poster_path = json['poster_path'],
        id = json['id'] as int,
        title = json['title'];

  @override
  String toString() {
    return 'MovieModel{id: $id, title: $title, poster_path: $poster_path}';
  }
}
