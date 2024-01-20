import 'package:flutter/material.dart';
import 'package:my_football_app/screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

// Importa otras pantallas aquí según sea necesario

class AppRoutes {
  static const String profile = '/profile';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
    // Añade más rutas según sea necesario
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen()); // Pantalla por defecto
    }
  }
}
