import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/movie.dart';
// class responsible for loading movie data
class MovieDataSource {
  // loads movies from a json file asynchronously
  Future<List<Movie>> loadMovies() async {
    final String response = await rootBundle.loadString('assets/data/movies.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Movie.fromJson(json)).toList();
  }
}