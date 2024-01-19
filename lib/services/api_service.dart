import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/models/movie_detail_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final moviesData = responseData['results'];
      for (var movie in moviesData) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }

    throw Error();
  }

  static Future<List<MovieModel>> getnowMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/now-playing');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final moviesData = responseData['results'];
      for (var movie in moviesData) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }

    throw Error();
  }

  static Future<List<MovieModel>> getComingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/coming-soon');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final moviesData = responseData['results'];
      for (var movie in moviesData) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }

    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetailById(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
