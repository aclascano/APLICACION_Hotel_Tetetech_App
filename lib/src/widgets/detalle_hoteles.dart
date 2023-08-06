import 'package:flutter/material.dart';
import 'package:hotel_tetetech_app/src/models/hotel.dart';
import 'package:hotel_tetetech_app/src/bloc/hotel_bloc.dart';

class HotelDetailScreen extends StatelessWidget {
  final int hotelId;
  final HotelManager _hotelManager = HotelManager();

  HotelDetailScreen({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del hotel',
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
      body: FutureBuilder<Hotel?>(
        future: _hotelManager.getHotelDetailByIndex(hotelId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error al cargar los detalles del hotel'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No se encontraron detalles del hotel'));
          } else {
            var hotel = snapshot.data!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotel ${hotel.nombre}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Image.network(
                    hotel.fotografia!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Información del Hotel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Calificación: ${hotel.calificacion}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Ubicación: ${hotel.ubicacion}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Precio Base: ${hotel.precioBase}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Descripción: ${hotel.descripcion}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Servicios: ${hotel.servicios?.join(', ')}',
                    style: TextStyle(fontSize: 16),
                  ),
                  /////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 12),
                  Text(
                    'Disponibilidad:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Table(
                    border: TableBorder.all(
                      color: Colors.black, // Color de las líneas de la tabla
                      width: 0.1, // Grosor de las líneas de la tabla
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Habitaciones Matrimoniales:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle, 
                            child: Text(
                              ' ${hotel.disponibilidad?.habitacionesMatrimoniales ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle, 
                            child: Text(
                              ' ${hotel.disponibilidad?.precioMatrimonial ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Habitaciones Familiares:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              ' ${hotel.disponibilidad?.habitacionesFamiliares ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              ' ${hotel.disponibilidad?.precioFamiliar ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Habitaciones Grupales:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              ' ${hotel.disponibilidad?.habitacionesGrupales ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              ' ${hotel.disponibilidad?.precioGrupal ?? 0}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 11),
                  Text(
                    'Contacto:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Correo: ${hotel.contacto?.correo}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Número de Teléfono: ${hotel.contacto?.numeroTelefono}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Instagram: ${hotel.contacto?.instagram}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Facebook: ${hotel.contacto?.facebook}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Sitio Web: ${hotel.contacto?.sitioWeb}',
                    style: TextStyle(fontSize: 16),
                  ),
                  
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
