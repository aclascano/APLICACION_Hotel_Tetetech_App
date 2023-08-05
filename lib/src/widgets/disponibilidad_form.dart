import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_tetetech_app/src/data/hotelinfo_data.dart';
import 'package:hotel_tetetech_app/src/widgets/contacto_form.dart';

import '../data/hotelcontacto_data.dart';
import '../data/hoteldisponibilidad_data.dart';
import '../data/hotelfotografia_data.dart';
import '../screens/añadir_hotel.dart';

class DisponibilidadForm extends StatelessWidget {
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final AgregarHotelScreen agregarHotelScreen;
  
  
  final TextEditingController habitacionesFamiliaresController = TextEditingController();
  final TextEditingController habitacionesGrupalesController = TextEditingController();
  final TextEditingController habitacionesMatrimonialesController = TextEditingController();
  final TextEditingController precioMatrimonialController = TextEditingController();
  final TextEditingController precioFamiliarController = TextEditingController();
  final TextEditingController precioGrupalController = TextEditingController();

  DisponibilidadForm({required this.info ,required this.disponibilidad,required this.contacto,required this.fotografia, required this.agregarHotelScreen});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 2. Información sobre disponibilidad'),
            SizedBox(height: 16),
            TextField(
              controller: habitacionesFamiliaresController,
              onChanged: (value) => disponibilidad.habitacionesFamiliares = int.tryParse(value),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
              decoration: InputDecoration(labelText: 'Habitaciones Familiares Disponibles'),
              
            ),
            SizedBox(height: 16),
            TextField(
              controller: habitacionesGrupalesController,
              onChanged: (value) => disponibilidad.habitacionesGrupales = int.tryParse(value),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
              decoration: InputDecoration(labelText: 'Habitaciones Grupales Disponibles'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: habitacionesMatrimonialesController,
              onChanged: (value) => disponibilidad.habitacionesMatrimoniales = int.tryParse(value),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
              decoration: InputDecoration(labelText: 'Habitaciones Matrimoniales Disponibles'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: precioMatrimonialController,
              onChanged: (value) => disponibilidad.precioMatrimonial = double.tryParse(value),
              keyboardType: TextInputType.numberWithOptions(decimal: true), 
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), 
              ],
              decoration: InputDecoration(labelText: 'Precio Habitación Matrimonial'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: precioFamiliarController,
              onChanged: (value) => disponibilidad.precioFamiliar = double.tryParse(value),
              keyboardType: TextInputType.numberWithOptions(decimal: true), 
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), 
              ],
              decoration: InputDecoration(labelText: 'Precio Habitación Familiar'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: precioGrupalController,
              onChanged: (value) => disponibilidad.precioGrupal = double.tryParse(value),
              keyboardType: TextInputType.numberWithOptions(decimal: true), 
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), 
              ],
              decoration: InputDecoration(labelText: 'Precio Habitación Grupal'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para retroceder a la pantalla anterior
                    Navigator.pop(context);
                  },
                  child: Text('Retroceder'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactoForm(info: info, disponibilidad: disponibilidad, contacto: contacto, fotografia: fotografia, agregarHotelScreen: agregarHotelScreen,),
                      ),
                    );
                    
                  },
                  child: Text('Siguiente'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}