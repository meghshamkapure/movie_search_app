import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String posterUrl;
  final String description;
  final double rating;
  final String duration;
  final String genre;
  final String releaseDate;
  final bool isFavorite;
  final bool isInWatchlist;

  const Movie({
    required this.title,
    required this.posterUrl,
    required this.description,
    required this.rating,
    required this.duration,
    required this.genre,
    required this.releaseDate,
    this.isFavorite = false,
    this.isInWatchlist = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? '',
      posterUrl: json['posterUrl'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      genre: json['genre'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'posterUrl': posterUrl,
      'description': description,
      'rating': rating,
      'duration': duration,
      'genre': genre,
      'releaseDate': releaseDate,
    };
  }

  Movie copyWith({
    String? title,
    String? posterUrl,
    String? description,
    double? rating,
    String? duration,
    String? genre,
    String? releaseDate,
    bool? isFavorite,
    bool? isInWatchlist,
  }) {
    return Movie(
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      genre: genre ?? this.genre,
      releaseDate: releaseDate ?? this.releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
    );
  }

  @override
  List<Object?> get props => [
    title,
    posterUrl,
    description,
    rating,
    duration,
    genre,
    releaseDate,
    isFavorite,
    isInWatchlist,
  ];
}