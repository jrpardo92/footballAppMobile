import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _storage = FlutterSecureStorage();

  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  void _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await http.post(
        Uri.parse('${AppConfig.apiBaseUrl}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correoElectronico': event.correoElectronico, 'contraseña': event.contrasena}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Almacenamiento del userID
        /** if (data.containsKey('userID')) {
          int userId = data['userID'];
          await _storage.write(key: 'userId', value: userId.toString());
          print('UserID almacenado en AuthBloc: $userId');
        }*/
        if (data.containsKey('userID')) {
          final prefs = await SharedPreferences.getInstance();
          int userId = data['userID'];
          await prefs.setInt('userId', userId);
          print('UserID almacenado en SharedPreferences: $userId');
        }

        // Almacenamiento del token JWT
        String token = data['token'];
        await _storage.write(key: 'jwt_token', value: token);

        emit(AuthSuccess());
      } else {
        // Manejar respuesta no exitosa del servidor
        try {
          final data = json.decode(response.body);
          emit(AuthFailure('Error de inicio de sesión: ${data['mensaje']}'));
        } catch (e) {
          emit(AuthFailure('Error de inicio de sesión: ${response.body}'));
        }
      }
    } on SocketException {
      emit(AuthFailure('No se pudo conectar con el servidor'));
    } catch (e) {
      emit(AuthFailure('Error inesperado: $e'));
    }
  }

  // Manejador del evento SignOutRequested
  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('userId');
    emit(AuthLoggedOut());
  }

  // Método para obtener el token JWT almacenado
  Future<String?> getJwtToken() async {
    return await _storage.read(key: 'jwt_token');
  }

}
