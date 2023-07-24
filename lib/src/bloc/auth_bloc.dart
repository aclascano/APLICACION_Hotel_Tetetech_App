import 'package:hotel_tetetech_app/src/services/auth_service.dart';
import '../models/user.dart';

class AuthManager {
  final AuthService _authService = AuthService();

  // Método para registrar un nuevo usuario con email y contraseña
  Future<Usuario?> registerWithEmailAndPassword(String email, String password) async {
    return _authService.registerWithEmailAndPassword(email, password);
  }

  // Método para iniciar sesión con email y contraseña
  Future<Usuario?> signInWithEmailAndPassword(String email, String password) async {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Método para obtener el usuario actualmente autenticado (si lo hay)
  Usuario? getCurrentUser() {
    return _authService.getCurrentUser();
  }

  // Método para verificar si el usuario actual está autenticado
  bool isAuthenticated() {
    return getCurrentUser() != null;
  }
}
