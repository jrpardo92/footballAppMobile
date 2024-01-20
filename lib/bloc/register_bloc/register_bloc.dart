import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_football_app/bloc/register_bloc/register_event.dart';
import 'package:my_football_app/bloc/register_bloc/register_state.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  void _onRegisterRequested(RegisterRequested event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.apiBaseUrl}/register'), // Utiliza la variable de configuración
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': event.nombre,
          'edad': event.edad,
          'ciudadResidencia': event.ciudadResidencia,
          'correoElectronico': event.correoElectronico,
          'contraseña': event.contrasena,
        }),
      );

      if (response.statusCode == 200) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure('Error al registrar: ${response.body}'));
      }
    } catch (e) {
      emit(RegisterFailure('Error al conectar con la base de datos: $e'));
    }
  }
}
