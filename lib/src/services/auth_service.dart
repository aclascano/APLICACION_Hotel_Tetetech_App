import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para registrar un nuevo usuario con email y contraseña
  Future<Usuario?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        return Usuario(
          id: user.uid,
          nombre: '', // Puedes agregar aquí el nombre del usuario si lo deseas
          correo: user.email,
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error en el registro de usuario: $e');
      return null;
    }
  }

  // Método para iniciar sesión con email y contraseña
  Future<Usuario?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Aquí podrías obtener más detalles del usuario si es necesario
        return Usuario(
          id: user.uid,
          nombre: user.displayName,
          correo: user.email,
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error en el inicio de sesión: $e');
      return null;
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Método para obtener el usuario actualmente autenticado (si lo hay)
  Usuario? getCurrentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      return Usuario(
        id: user.uid,
        nombre: user.displayName,
        correo: user.email,
      );
    } else {
      return null;
    }
  }
}
