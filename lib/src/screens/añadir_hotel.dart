import 'package:flutter/material.dart';
import '../data/hotelcontacto_data.dart';
import '../data/hoteldisponibilidad_data.dart';
import '../data/hotelfotografia_data.dart';
import '../data/hotelinfo_data.dart';
import '../widgets/contacto_form.dart';
import '../widgets/disponibilidad_form.dart';
import '../widgets/fotografia_form.dart';
import '../widgets/info_form.dart';

class AgregarHotelScreen extends StatelessWidget {

   void printHotelInfo() {
  
} 

  final Hotelinfo info = Hotelinfo();
  final HotelDisponibilidad disponibilidad = HotelDisponibilidad();
  final HotelContacto contacto = HotelContacto();
  final HotelFotografia fotografia = HotelFotografia();

  @override
  Widget build(BuildContext context) {
    return Theme(data: appTheme, 
    child: Navigator(
      pages: [
        // Agregar todas las páginas del proceso en el orden que desees mostrarlas
        MaterialPage(child: FotografiaForm(info:info,disponibilidad: disponibilidad,contacto: contacto, fotografia: fotografia, agregarHotelScreen: this)),
        MaterialPage(child: ContactoForm(info:info,disponibilidad: disponibilidad,contacto: contacto, fotografia: fotografia, agregarHotelScreen: this)),
        MaterialPage(child: DisponibilidadForm(info:info,disponibilidad: disponibilidad,contacto: contacto , fotografia: fotografia, agregarHotelScreen: this)),
        MaterialPage(child: InfoForm(info:info, disponibilidad: disponibilidad,contacto: contacto , fotografia: fotografia, agregarHotelScreen: this)),
        
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (route.settings.name == '/fotografia') {
        } else if (route.settings.name == '/contacto') {
          disponibilidad.habitacionesMatrimoniales = null; 
        } else if (route.settings.name == '/disponibilidad') {
          contacto.correo = null; 
        }

        return true;
      },
    )
    );
  }
}
final appTheme = ThemeData(
  
  primarySwatch: Colors.brown,
  
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), 
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    labelStyle: TextStyle(color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    ),
  ),
);
