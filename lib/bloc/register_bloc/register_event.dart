// ignore_for_file: non_constant_identifier_names

abstract class RegisterEvent {}

class RegisterRequested extends RegisterEvent {
  final String nombre;
  final int edad;
  final String ciudadResidencia;
  final String correoElectronico;
  final String contrasena;

  RegisterRequested({
    required this.nombre,
    required this.edad,
    required this.ciudadResidencia,
    required this.correoElectronico,
    required this.contrasena,
  });
}
