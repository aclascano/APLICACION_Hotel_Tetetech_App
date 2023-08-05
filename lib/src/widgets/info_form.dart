import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_tetetech_app/src/data/hotelcontacto_data.dart';
import 'package:hotel_tetetech_app/src/data/hoteldisponibilidad_data.dart';
import 'package:hotel_tetetech_app/src/data/hotelfotografia_data.dart';
import 'package:hotel_tetetech_app/src/data/hotelinfo_data.dart';
import 'package:hotel_tetetech_app/src/widgets/disponibilidad_form.dart';

import '../screens/añadir_hotel.dart';

class InfoForm extends StatelessWidget {
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final AgregarHotelScreen agregarHotelScreen;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController calificacionController = TextEditingController();
  final TextEditingController precioBaseController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController serviciosController = TextEditingController();

  InfoForm(
      {required this.info,
      required this.disponibilidad,
      required this.contacto,
      required this.fotografia,
      required this.agregarHotelScreen});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 1. Información del hotel'),
            SizedBox(height: 16),
            TextField(
              controller: nombreController,
              onChanged: (value) => info.nombre = value,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: info.ubicacion, 
              onChanged: (newValue) {
                
                info.ubicacion = newValue;
              },
              items: [
                DropdownMenuItem(value: 'Quito', child: Text('Quito')),
                DropdownMenuItem(value: 'Guayaquil', child: Text('Guayaquil')),
                DropdownMenuItem(value: 'Cuenca', child: Text('Cuenca')),
                DropdownMenuItem(value: 'Ambato', child: Text('Ambato')),
                DropdownMenuItem(value: 'Loja', child: Text('Loja')),
                DropdownMenuItem(value: 'Manta', child: Text('Manta')),
                DropdownMenuItem(value: 'Esmeraldas', child: Text('Esmeraldas')),
                DropdownMenuItem(value: 'Puyo', child: Text('Puyo')),
                DropdownMenuItem(value: 'Santo Domingo', child: Text('Santo Domingo')),
                DropdownMenuItem(value: 'Porto Viejo', child: Text('Porto Viejo')),
                
              ],
              decoration: InputDecoration(labelText: 'Ubicación'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: calificacionController,
              onChanged: (value) => info.calificacion = int.tryParse(value),
              decoration: InputDecoration(labelText: 'Calificacion'),
              keyboardType: TextInputType.number, 
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: precioBaseController,
              onChanged: (value) => info.precioBase = double.tryParse(value),
              decoration: InputDecoration(labelText: 'Precio Base'),
              keyboardType: TextInputType.numberWithOptions(decimal: true), 
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), 
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              onChanged: (value) => info.descripcion = value,
              decoration: InputDecoration(labelText: 'Descripccion'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: serviciosController,
              onChanged: (value) => info.servicios =
                  value.split(',').map((e) => e.trim()).toList(),
              decoration: InputDecoration(labelText: 'Servicios'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisponibilidadForm(
                      info: info,
                      disponibilidad: disponibilidad,
                      contacto: contacto,
                      fotografia: fotografia,
                      agregarHotelScreen: agregarHotelScreen,
                    ),
                  ),
                );
              },
              child: Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
