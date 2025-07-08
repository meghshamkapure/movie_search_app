import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'data/datasources/movie_data_source.dart';
import 'data/repositories/movie_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/auth/auth_state.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/main_navigation.dart';
import 'presentation/screens/splash_screen.dart';


//runs the app
void main() {
  runApp(const MovieSearchApp());
}

//AppHomeScreen
class MovieSearchApp extends StatelessWidget {
  const MovieSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => MovieRepository(dataSource: MovieDataSource())),
      ],
      child: BlocProvider(
        create: (context) =>
        AuthBloc(authRepository: context.read<AuthRepository>())..add(AppStarted()),
        child: const AppNavigator(),
      ),
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  bool showLogin = false;
  bool showRegister = false;
  bool showSimpleSplash = true;

  void showLoginScreen() {
    setState(() {
      showLogin = true;
      showRegister = false;
    });
  }

  void showRegisterScreen() {
    setState(() {
      showLogin = false;
      showRegister = true;
    });
  }

  void showSplashScreen() {
    setState(() {
      showLogin = false;
      showRegister = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showSimpleSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search App',
      theme: ThemeData.dark(),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (showSimpleSplash) {
            return const SplashScreen();
          }
          if (state is Authenticated) {
            return const MainNavigation();
          } else if (showLogin) {
            return LoginScreen(onRegisterTap: showRegisterScreen);
          } else if (showRegister) {
            return RegisterScreen(onLoginTap: showLoginScreen);
          } else {
            return SplashScreenWithButtons(
              onRegisterTap: showRegisterScreen,
              onLoginTap: showLoginScreen,
            );
          }
        },
      ),
    );
  }
}