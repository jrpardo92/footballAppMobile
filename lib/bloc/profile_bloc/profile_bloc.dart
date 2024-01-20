import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import 'dart:convert';

// Eventos
abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {}

// Estados
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userProfile;
  ProfileLoaded(this.userProfile);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

// BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
  }

  void _onLoadUserProfile(LoadUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final response = await http.get(Uri.parse('${AppConfig.apiBaseUrl}/users/id')); // Asegúrate de tener la ruta correcta
      if (response.statusCode == 200) {
        final Map<String, dynamic> userProfile = json.decode(response.body);
        emit(ProfileLoaded(userProfile));
      } else {
        emit(ProfileError('Error al cargar el perfil: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProfileError('Error al conectar con el servidor: $e'));
    }
  }
}