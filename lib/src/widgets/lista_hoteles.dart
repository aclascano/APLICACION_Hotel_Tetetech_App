import 'package:flutter/material.dart';

import '../bloc/hotel_bloc.dart';
import 'detalle_hoteles.dart';

class HotelesList extends StatelessWidget {
  final HotelManager hotelManager = HotelManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
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
                    return Column(
                      children: [
                        SizedBox(height: 12),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          elevation:
                              4, // Elevación del Card para una sombra suave
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Borde redondeado
                          ),
                          child: ListTile(
                            leading: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                hotel['fotografia'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.all(16), // Espaciado interno
                            title: Text(
                              hotel['nombre'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  'Calificación: ${hotel['calificacion']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Ubicación: ${hotel['ubicacion']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Precio: ${hotel['precio']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Disponibilidad: ${hotel['disponibilidad']} habitaciones',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Mas informacion: '),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HotelDetailScreen(
                                                    hotelId: index,),
                                          ),
                                          
                                        );
                                        print(index.toString());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
