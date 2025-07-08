Movie Search Application
Overview
This Flutter application allows users to search for movies, view detailed movie information, manage a watchlist, and bookmark favorite movies. The app integrates a local JSON file for movie data, uses the BLoC pattern for state management, and provides a clean, modern, and responsive UI design as per the provided Figma specifications.
Features

Login/Register: Users can sign up and log in to access the app's features.
Movie Search: Search movies by name, with results filtered from a local JSON file.
Movie Details: Displays comprehensive movie information, including title, poster, description, rating, duration, genre, and release date.
Watchlist: Users can add movies to a watchlist, accessible via the bottom navigation bar.
Favorite/Bookmark Movies: Users can bookmark favorite movies, stored locally using SharedPreferences or SQLite.
State Management: Implemented using the BLoC pattern to handle search queries, data states (loading, success, failure), and UI feedback (e.g., no results found).
UI/UX Design: Clean, intuitive, and responsive design with smooth navigation and transitions, optimized for various screen sizes.
JSON Integration: Movie data is fetched from a JSON file stored in the assets folder, containing details for 10-15 movies.
```
Project Structure
lib/
├── bloc/                    # BLoC classes for state management
├── models/                  # Data models (e.g., Movie, User)
├── screens/                 # UI screens (e.g., Login, Search, Movie Details)
├── widgets/                 # Reusable UI components
├── services/                # Data handling (e.g., JSON parsing, local storage)
├── assets/                  # JSON file and other assets
└── main.dart                # Entry point of the application
```
Dependencies

flutter_bloc: For state management.
shared_preferences or sqflite: For local storage of watchlist and favorite movies.
http: For handling JSON data (if needed for future API integration).
cached_network_image: For efficient loading of movie poster images.
equatable: To simplify BLoC state comparison.

Setup Instructions

Clone the Repository:git clone <repository-url>
cd movie_search_app


Install Dependencies:flutter pub get


Configure Assets:
Place the movies.json file in the assets/ folder.
Update pubspec.yaml to include the assets:assets:
  - assets/movies.json




Run the App:flutter run



JSON File
The movie data is stored in assets/movies.json. A sample structure is provided below:
[
  {
    "title": "Inception",
    "posterUrl": "https://example.com/inception.jpg",
    "description": "A skilled thief is given a chance to erase his criminal record by implanting an idea into the mind of a CEO.",
    "rating": 4.5,
    "duration": "2hr 20m",
    "genre": "Sci-Fi, Thriller",
    "releaseDate": "2010-07-16"
  },
  {
    "title": "The Dark Knight",
    "posterUrl": "https://example.com/dark-knight.jpg",
    "description": "When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
    "rating": 5.0,
    "duration": "2hr 40m",
    "genre": "Action, Crime, Drama",
    "releaseDate": "2008-07-18"
  }
]

Usage

Login/Register: Create an account or log in to access the app.
Search Movies: Use the search bar to filter movies by title.
View Details: Tap a movie to view its details, including poster, description, and more.
Manage Watchlist: Add movies to your watchlist for later viewing.
Bookmark Favorites: Mark movies as favorites, which are saved locally.
Navigation: Use the bottom navigation bar to switch between Search, Watchlist, and Favorites screens.

Design Reference
The UI is based on the Figma design provided at: Figma Link.
Evaluation Criteria

Code Quality: Clean, modular, and well-documented code with proper BLoC usage.
UI/UX: Responsive, visually appealing design with smooth transitions.
Functionality: Accurate search, persistent watchlist/favorites, and detailed movie info.
State Management: Efficient handling of app states (loading, success, failure).
Performance: Smooth interactions and optimized data handling.

Notes

The app uses local storage for watchlist and favorites to ensure data persistence.
Error handling is implemented for invalid search queries, network issues (if applicable), and JSON parsing.
The JSON file contains 10-15 movies with all required fields as per the sample structure.


