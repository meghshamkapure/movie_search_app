import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/movie_repository.dart';
import '../bloc/movie/movie_bloc.dart';

import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'watchlist/watchlist_screen.dart';
import 'favorites/favorites_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late final MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    // Create the MovieBloc once and share it
    _movieBloc = MovieBloc(repository: context.read<MovieRepository>());
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      BlocProvider.value(
        value: _movieBloc,
        child: HomeScreen(),
      ),
      BlocProvider.value(
        value: _movieBloc,
        child: SearchScreen(),
      ),
      BlocProvider.value(
        value: _movieBloc,
        child: WatchlistScreen(),
      ),
      BlocProvider.value(
        value: _movieBloc,
        child: FavoritesScreen(),
      ),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF5C443),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}