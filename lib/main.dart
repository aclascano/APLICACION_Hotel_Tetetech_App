import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_tetetech_app/src/bloc/hotel_bloc.dart';
import 'package:hotel_tetetech_app/src/screens/a%C3%B1adir_hotel.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(title: Text('Lista de Hoteles')),
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

class HotelListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: HotelManager().getHotelGeneral(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text('Error al obtener la lista de hoteles.'),
          );
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text('No hay hoteles disponibles.'),
          );
        } else {
          final List<Map<String, dynamic>> hoteles = snapshot.data!;
          return ListView.builder(
            itemCount: hoteles.length,
            itemBuilder: (context, index) {
              final hotel = hoteles[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ListTile(
                  title: Text(hotel['nombre']),
                  subtitle: Text(
                      'Calificación: ${hotel['calificacion']}\nUbicación: ${hotel['ubicacion']}'),
                  trailing: Text('Precio: ${hotel['precio']}'),
                ),
              );
            },
          );
        }
      },
    );
  }
}

