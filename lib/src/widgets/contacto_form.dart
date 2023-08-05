import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_tetetech_app/src/data/hotelcontacto_data.dart';
import 'package:hotel_tetetech_app/src/data/hotelfotografia_data.dart';

import '../data/hoteldisponibilidad_data.dart';
import '../data/hotelinfo_data.dart';
import '../screens/añadir_hotel.dart';
import 'fotografia_form.dart';

class ContactoForm extends StatelessWidget {
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final AgregarHotelScreen agregarHotelScreen;
  final TextEditingController correoController = TextEditingController();
  final TextEditingController numeroTelefonoController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController sitioWebController = TextEditingController();

  ContactoForm({required this.info, required this.disponibilidad,required this.contacto, required this.fotografia, required this.agregarHotelScreen});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 3. Información sobre el Contacto'),
            SizedBox(height: 16),
             TextField(
              controller: correoController,
              onChanged: (value) => contacto.correo = value,
              decoration: InputDecoration(labelText: 'Correo de Contacto'),
              keyboardType: TextInputType.emailAddress,
              
            ),
            SizedBox(height: 16),
            TextField(
              controller: numeroTelefonoController,
              onChanged: (value) => contacto.numeroTelefono = value,
              decoration: InputDecoration(labelText: 'Número de Teléfono de Contacto'),
              keyboardType: TextInputType.number, 
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: facebookController,
              onChanged: (value) => contacto.facebook = value,
              decoration: InputDecoration(labelText: 'Facebook de Contacto'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: instagramController,
              onChanged: (value) => contacto.instagram = value,
              decoration: InputDecoration(labelText: 'Instagram de Contacto'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: sitioWebController,
              onChanged: (value) => contacto.sitioWeb = value,
              decoration: InputDecoration(labelText: 'Sitio Web de Contacto'),
              keyboardType: TextInputType.url,
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
                    String correo = correoController.text;
                    String sitioWeb = sitioWebController.text;

                    if (correo.isEmpty || sitioWeb.isEmpty) {
                      // Validación: ningún campo puede estar vacío
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ningún campo puede estar vacío')),
                      );
                    } else if (!isValidEmail(correo)) {
                      // Validación: formato de correo electrónico inválido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ingrese un correo electrónico válido')),
                      );
                    } else if (!isValidUrl(sitioWeb)) {
                      // Validación: formato de URL inválido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ingrese una URL válida')),
                      );
                    } else {
                      // Si pasa todas las validaciones, navegar al siguiente paso
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FotografiaForm(info:info, disponibilidad: disponibilidad, contacto: contacto,fotografia: fotografia, agregarHotelScreen: agregarHotelScreen),
                        ),
                      );
                    }
                    
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
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidUrl(String url) {
    final urlRegExp = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
    return urlRegExp.hasMatch(url);
  }
}
