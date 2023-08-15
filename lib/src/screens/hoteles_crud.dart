
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'añadir_hotel.dart';
import 'mostrar_hotel_admin.dart';

class HotelCrudScreen extends StatefulWidget{
  @override
  _HotelCrudScreenState createState() => _HotelCrudScreenState();
}

class _HotelCrudScreenState extends State<HotelCrudScreen>{
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _screens = [
    HotelListView(),
    AgregarHotelScreen(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Center(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista de Hoteles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Agregar Hotel',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}