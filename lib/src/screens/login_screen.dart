import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
        appBar: AppBar(
          title: Text(
            'Inicio de Sesión',
            style: TextStyle(
              fontFamily: 'Montserrat', // Cambia la fuente
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0, // Sin sombra
        ),
        */
        body: Stack(
      children: [
        // Centra la imagen en el Stack
        Align(
          alignment: Alignment.topCenter,
          child: Transform.scale(
            scale: 0.9,
            child: Image.asset(
              'assets/images/icono_login.png',
              height: 470,
              width: 300,
            ),
          ),
        ),
        // Coloca el contenido encima de la imagen de fondo

        Padding(
          padding: const EdgeInsets.only(top: 380.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Inicio de Sesión',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Montserrat', // Cambia la fuente
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 30, width: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Ningún campo puede estar vacío')),
                        );
                      } else if (!isValidEmail(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('El correo electrónico no es valido')),
                        );
                      } else {
                        Usuario? usuario =
                            await AuthService().loginUser(email, password);

                        if (usuario != null) {
                          if (usuario.rol == 'admin') {
                            Navigator.pushNamed(context, '/hoteles_crud');
                          } else {
                            Navigator.pushNamed(context, '/hoteles_index');
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Hubo un error al iniciar sesión')),
                          );
                        }
                      }
                    },
                    child: Text('Iniciar Sesión'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: TextStyle(
                        fontFamily: 'Montserrat', // Cambia la fuente
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro
                      Navigator.pushNamed(context, '/registro');
                    },
                    child: Text(
                      '¿No estás registrado? Regístrate',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
}
