import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_event.dart';
import '../config.dart';
import '../shared_preferences_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchProfile();
  }

  Future<void> _loadUserIdAndFetchProfile() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    int? userId = await prefsService.getUserId();
    print('UserID recuperado en Profile Screen: $userId');

    if (userId != null) {
      _fetchUserProfile(userId);
    } else {
      print('UserID no encontrado en Profile Screen');
    }
  }

  Future<void> _fetchUserProfile(int userId) async {
    try {
      var url = Uri.parse('${AppConfig.apiBaseUrl}/users/$userId');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          userProfile = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print('Error al obtener el perfil: ${response.body}');
      }
    } catch (e) {
      print('Error al obtener el perfil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userProfile != null
          ? ListView(
        children: <Widget>[
          ListTile(
            title: Text('Nombre'),
            subtitle: Text(userProfile!['nombre'] ?? 'No disponible'),
          ),
          ListTile(
            title: Text('Edad'),
            subtitle: Text('${userProfile!['edad'].toString() ?? 'No disponible'}'),
          ),
          ListTile(
            title: Text('Ciudad de Residencia'),
            subtitle: Text(userProfile!['ciudadResidencia'] ?? 'No disponible'),
          ),
          ListTile(
            title: Text('Correo Electrónico'),
            subtitle: Text(userProfile!['correoElectronico'] ?? 'No disponible'),
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
              Navigator.of(context).pushReplacementNamed('/login'); // Navega a la pantalla de inicio de sesión
            },
            child: Text('Cerrar Sesión'),
          )
        ],
      )
          : Center(child: Text('No se pudo cargar la información del perfil')),
    );
  }
}
