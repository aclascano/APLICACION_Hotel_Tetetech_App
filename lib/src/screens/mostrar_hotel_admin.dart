import 'package:flutter/material.dart';
import 'package:hotel_tetetech_app/src/bloc/hotel_bloc.dart';
import 'package:hotel_tetetech_app/src/services/hotel_service.dart';

class HotelListView extends StatefulWidget {
  @override
  _HotelListViewState createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  final HotelManager hotelManager = HotelManager();
  final HotelService hotelService = HotelService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                      child: ListTile(
                        title: Text(hotel['nombre']),
                        subtitle: 
                        Row(children: [
                          Text(
                            'Calificación: ${hotel['calificacion']}\nUbicación: ${hotel['ubicacion']}'),
                          Text('Precio: ${hotel['precioBase']}'),
                          SizedBox(
                              width: 50), // Espacio entre el texto y el botón
                          ElevatedButton(
                            onPressed: () {
                              hotelService.deleteHotelByIndex(index);
                              setState(() {});
                            },
                            child: Text('Eliminar'),
                          ),
                          
                        ]),
                        
                        
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
