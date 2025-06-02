import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/movie/movie_bloc.dart';
import '../../bloc/movie/movie_event.dart';
import '../../bloc/movie/movie_state.dart';
import '../../../models/movie.dart';
import '../../widgets/movie_card.dart';
import '../details/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(LoadMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              final movies = state.movies;
              if (movies.isEmpty) {
                return const Center(child: Text('No movies found.', style: TextStyle(color: Colors.white)));
              }
              // For demo, use first 3 as featured
              final featured = movies.take(3).toList();
              // Show all remaining movies in the grid
              final allGridMovies = movies
                  .skip(3)
                  .where((m) => m.posterUrl.isNotEmpty && m.title.isNotEmpty && m.genre.isNotEmpty)
                  .toList();

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Search bar and bell icon
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search movie',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFFF5C443), width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFFF5C443), width: 2),
                              ),
                              prefixIcon: const Icon(Icons.search, color: Color(0xFFF5C443)),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onSubmitted: (query) {
                              // Optionally trigger search
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Color(0xFFF5C443), width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.notifications, color: Color(0xFFF5C443)),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Carousel
                  SizedBox(
                    height: 180,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: featured.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final movie = featured[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailsScreen(movie: movie),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    buildMovieImage(movie.posterUrl),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                                        ),
                                      ),
                                      child: Text(
                                        movie.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Dots indicator
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              featured.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: _currentPage == index ? 12 : 8,
                                height: _currentPage == index ? 12 : 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index ? Colors.white : Colors.white38,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // All movies grid (no header)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: allGridMovies.length,
                    itemBuilder: (context, index) {
                      final movie = allGridMovies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailsScreen(movie: movie),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFF5C443), width: 1),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                // Movie image fills the card
                                Positioned.fill(
                                  child: buildMovieImage(movie.posterUrl),
                                ),
                                // Gradient at the bottom
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.85),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.85),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            movie.title,
                                            style: const TextStyle(
                                              color: Color(0xFFF5C443),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            movie.genre,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Favorite icon (top left)
                                Positioned(
                                  top: 6,
                                  left: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      final bloc = context.read<MovieBloc>();
                                      if (movie.isFavorite) {
                                        bloc.add(RemoveFromFavorites(movie));
                                      } else {
                                        bloc.add(AddToFavorites(movie));
                                      }
                                    },
                                    child: Icon(
                                      movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      size: 32,
                                    ),
                                  ),
                                ),
                                // Watchlist icon (top right)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      final bloc = context.read<MovieBloc>();
                                      if (movie.isInWatchlist) {
                                        bloc.add(RemoveFromWatchlist(movie));
                                      } else {
                                        bloc.add(AddToWatchlist(movie));
                                      }
                                    },
                                    child: Icon(
                                      movie.isInWatchlist ? Icons.bookmark : Icons.bookmark_border,
                                      color: Color(0xFFF5C443),
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Add more sections as needed...
                ],
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildMovieImage(String url) {
    if (url.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(color: Color(0xFFF5C443), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(color: Color(0xFFF5C443), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}