import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_football_app/screens/home_screen.dart';
import 'package:my_football_app/screens/splash_screen.dart';
import 'Routes/app_routes.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/profile_bloc/profile_bloc.dart';
import 'bloc/register_bloc/register_bloc.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        // Aquí puedes añadir más BlocProviders si es necesario
      ],
      child: MaterialApp(
        title: 'Flutter Football App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}