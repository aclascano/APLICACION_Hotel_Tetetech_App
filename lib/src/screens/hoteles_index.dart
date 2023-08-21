import 'package:flutter/material.dart';
import 'package:hotel_tetetech_app/src/widgets/lista_hoteles_precio.dart';
import '../services/auth_service.dart';
import '../widgets/lista_hoteles.dart';
import '../widgets/lista_hoteles_ubicacion.dart';


class HotelesScreen extends StatefulWidget {
  @override
  _HotelesScreenState createState() => _HotelesScreenState();
}
class _HotelesScreenState extends State<HotelesScreen> {
  final AuthService _authService = AuthService();

  String _filtroSeleccionado = 'Todo'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Hoteles',
          style: TextStyle(
            fontFamily: 'Montserrat', 
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, 
        elevation: 0, // Sin sombra
        iconTheme: IconThemeData(
          color: Colors.black, 
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 183, 154),
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
      body: Column(
        children: [
          SizedBox(height: 12),
          DropdownButton<String>(
            value: _filtroSeleccionado,
            items: ['Todo', 'Ubicación', 'Precio']
                .map((filtro) {
                  return DropdownMenuItem<String>(
                    value: filtro,
                    child: Text(filtro),
                  );
                })
                .toList(),
            onChanged: (newValue) {
              setState(() {
                _filtroSeleccionado = newValue!;
              });
            },
          ),
          Expanded(
            child: _buildSelectedWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedWidget() {
    if (_filtroSeleccionado == 'Todo') {
      return HotelesList();
    } else if (_filtroSeleccionado == 'Ubicación') {
      return HotelesListUbicacion();
    } 
    else if (_filtroSeleccionado == 'Precio') {
      return HotelesListPrecio();
    } 
    else {
      return SizedBox(); // Otros casos a manejar
    }
  }

}
