import 'package:flutter/material.dart';

import '../bloc/hotel_bloc.dart';
import 'detalle_hoteles.dart';

class HotelesList extends StatefulWidget {
  @override
  _HotelesListState createState() => _HotelesListState();
}

class _HotelesListState extends State<HotelesList> {
  final HotelManager hotelManager = HotelManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailScreen(
                          hotelId: index,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: Image.network(
                          hotel['fotografia'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel['nombre'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Calificación: ${hotel['calificacion']}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Ubicación: ${hotel['ubicacion']}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Precio: ${hotel['precioBase']}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Disponibilidad: ${hotel['disponibilidad']} habitaciones',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Más información: '),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
