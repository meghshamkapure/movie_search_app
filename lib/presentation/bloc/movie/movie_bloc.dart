import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/models/movie.dart';

import '../../../data/repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;
  List<Movie> movies = [];

  MovieBloc({required this.repository}) : super(MovieInitial()) {
    on<LoadMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        movies = await repository.getMovies();
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError('Failed to load movies'));
      }
    });

    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final filtered = movies
            .where((movie) =>
            movie.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(MovieLoaded(filtered));
      } catch (e) {
        emit(MovieError('Search failed'));
      }
    });

    on<AddToWatchlist>((event, emit) async {
      movies = movies.map((m) =>
        m.title == event.movie.title ? m.copyWith(isInWatchlist: true) : m
      ).toList();
      emit(MovieLoaded(movies));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      movies = movies.map((m) =>
        m.title == event.movie.title ? m.copyWith(isInWatchlist: false) : m
      ).toList();
      emit(MovieLoaded(movies));
    });

    on<AddToFavorites>((event, emit) async {
      movies = movies.map((m) =>
        m.title == event.movie.title ? m.copyWith(isFavorite: true) : m
      ).toList();
      emit(MovieLoaded(movies));
    });

    on<RemoveFromFavorites>((event, emit) async {
      movies = movies.map((m) =>
        m.title == event.movie.title ? m.copyWith(isFavorite: false) : m
      ).toList();
      emit(MovieLoaded(movies));
    });
  }
}