import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(String email, String password, String nombre) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Usuario nuevoUsuario = Usuario(
        id: authResult.user!.uid,
        nombre: nombre,
        correo: email,
        rol: 'cliente', // Rol por defecto
      );
      await _firestore
          .collection('usuarios')
          .doc(authResult.user!.uid)
          .set(nuevoUsuario.toJson());
    } catch (e) {
      print('Error en el registro: $e');
      throw e;
    }
  }

  Future<bool> validarRolUsuario(String userId, String rolValido) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('usuarios').doc(userId).get();
      Usuario usuario = Usuario.fromJson(userDoc.data() as Map<String, dynamic>);
      
      return usuario.rol == rolValido;
    } catch (e) {
      print('Error al validar el rol del usuario: $e');
      return false;
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      final result = await _auth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      print('Error while checking email registration: $e');
      return false;
    }
  }

  Future<Usuario?> loginUser(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc =
          await _firestore.collection('usuarios').doc(authResult.user!.uid).get();
      Usuario usuario = Usuario.fromJson(userDoc.data() as Map<String, dynamic>);

      return usuario;
    } catch (e) {
      print('Error en el inicio de sesión: $e');
      return null;
    }
  }
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
