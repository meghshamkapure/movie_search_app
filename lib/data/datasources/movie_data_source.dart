import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/movie.dart';

class MovieDataSource {
  Future<List<Movie>> loadMovies() async {
    final String response = await rootBundle.loadString('assets/data/movies.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Movie.fromJson(json)).toList();
  }
}