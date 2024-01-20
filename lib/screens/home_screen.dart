import 'package:flutter/material.dart';
import '../shared_preferences_service.dart';
import '/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido a la Aplicación de Fútbol',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes manejar la navegación o alguna acción
              },
              child: Text('Ver Partidos'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes manejar la navegación o alguna acción
              },
              child: Text('Crear Partido'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.profile);
                // Aquí puedes manejar la navegación o alguna acción
              },
              child: Text('Mi Perfil'),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  bool isStored = await _prefsService.isUserIdStored();
                  print('UserID está almacenado: $isStored');
                },
                child: Text('Verificar UserID en SharedPreferences'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
