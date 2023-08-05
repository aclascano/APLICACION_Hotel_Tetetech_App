import 'package:flutter/material.dart';
import 'package:hotel_tetetech_app/src/bloc/hotel_bloc.dart';

class HotelListView extends StatefulWidget {
  @override
  _HotelListViewState createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  final HotelManager hotelManager = HotelManager();
  final List<String> filtros = ['Ubicación', 'Calificación', 'Precio'];
  String filtroSeleccionado = 'Ubicación';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        DropdownButton<String>(
          value: filtroSeleccionado,
          items: filtros.map((filtro) {
            return DropdownMenuItem<String>(
              value: filtro,
              child: Text(filtro),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              filtroSeleccionado = newValue!;
              // Llama a un método para actualizar la lista de hoteles con el filtro seleccionado
              // Por ejemplo, si el filtro seleccionado es 'Ubicación', llamarías a:
              // actualizarHotelesPorUbicacion();
            });
          },
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: hotelManager.getHotelGeneral(),
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
                      margin: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
          ),
        ),
      ],
    );
  }
}
