import '../datasources/movie_data_source.dart';
import '../../models/movie.dart';

class MovieRepository {
  final MovieDataSource dataSource;

  MovieRepository({required this.dataSource});

  Future<List<Movie>> getMovies() async {
    return await dataSource.loadMovies();
  }
}