abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String correoElectronico;
  final String contrasena;

  SignInRequested({required this.correoElectronico, required this.contrasena});
}
class SignOutRequested extends AuthEvent {
  // Puedes añadir detalles adicionales aquí si son necesarios para el cierre de sesión.
}