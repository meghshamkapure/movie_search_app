import 'package:equatable/equatable.dart';

import '../../../models/movie.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies(this.query);

  @override
  List<Object?> get props => [query];
}

class AddToWatchlist extends MovieEvent {
  final Movie movie;
  AddToWatchlist(this.movie);
  @override
  List<Object?> get props => [movie];
}

class RemoveFromWatchlist extends MovieEvent {
  final Movie movie;
  RemoveFromWatchlist(this.movie);
  @override
  List<Object?> get props => [movie];
}

class AddToFavorites extends MovieEvent {
  final Movie movie;
  AddToFavorites(this.movie);
  @override
  List<Object?> get props => [movie];
}

class RemoveFromFavorites extends MovieEvent {  
  final Movie movie;
  RemoveFromFavorites(this.movie);
  @override
  List<Object?> get props => [movie];
}