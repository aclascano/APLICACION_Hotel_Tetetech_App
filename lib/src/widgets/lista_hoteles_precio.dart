import 'package:flutter/material.dart';

import '../bloc/hotel_bloc.dart';
import '../models/hotel.dart';
import 'detalle_hoteles.dart';

class HotelesListPrecio extends StatefulWidget {
  @override
  _HotelesListPrecioState createState() => _HotelesListPrecioState();
}

class _HotelesListPrecioState extends State<HotelesListPrecio> {
  final HotelManager hotelManager = HotelManager();

  double? minPrecio;
  double? maxPrecio;
  bool showHotels = false;

  final TextEditingController minPrecioController = TextEditingController();
  final TextEditingController maxPrecioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: minPrecioController,
            onChanged: (value) => minPrecio = double.tryParse(value),
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelText: 'Precio Mínimo',
              labelStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color.fromARGB(255, 92, 82, 63), width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: maxPrecioController,
            onChanged: (value) => maxPrecio = double.tryParse(value),
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelText: 'Precio Maximo',
              labelStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color.fromARGB(255, 92, 82, 63), width: 2),
              ),
            ),
          ),
          
        ),

        SizedBox(height: 12),
        Container(
          width: 120,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                showHotels = true;
              });
              
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 202, 166, 116),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Buscar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        if (showHotels)
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
                  final List<Hotel> hotelesFiltrados = hotelManager
                      .filtrarPorPrecio(hoteles, minPrecio!,maxPrecio!);

                  return ListView.builder(
                    itemCount: hotelesFiltrados.length,
                    itemBuilder: (context, index) {
                      final hotel = hotelesFiltrados[index];
                      int habitacionDisponible =
            (hotel.disponibilidad?.habitacionesFamiliares ?? 0) +
                (hotel.disponibilidad?.habitacionesGrupales ?? 0) +
                (hotel.disponibilidad?.habitacionesMatrimoniales ?? 0);
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
                                  hotel.fotografia.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.all(16), // Espaciado interno
                              title: Text(
                                hotel.nombre.toString(),
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
                                    'Calificación: ${hotel.calificacion}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Ubicación: ${hotel.ubicacion}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Precio: ${hotel.precioBase}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  
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
                                                hotelId: index,
                                              ),
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
