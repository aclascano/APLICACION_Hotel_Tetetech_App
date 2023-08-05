import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HotelesScreen extends StatefulWidget {
  @override
  _HotelesScreenState createState() => _HotelesScreenState();
}

class _HotelesScreenState extends State<HotelesScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoteles'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: FutureBuilder(
                future: _authService.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      var user = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bienvenido,',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            user!.displayName ?? 'Usuario',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text('Usuario no encontrado');
                    }
                  }
                },
              ),
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () async {
                await _authService.logoutUser();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Center(
        // Aquí iría el contenido de la pantalla de hoteles
        child: Text('Contenido de la pantalla de Hoteles'),
      ),
    );
  }
}
