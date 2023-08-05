import 'package:flutter/material.dart';
import 'package:hotel_tetetech_app/src/screens/hoteles_crud.dart';
import 'package:hotel_tetetech_app/src/screens/hoteles_index.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String registro = '/registro';
  static const String hoteles_crud = '/hoteles_crud';
  static const String hoteles_index = '/hoteles_index';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      registro: (context) => RegisterScreen(),
      hoteles_crud: (context) => HotelCrudScreen(),
      hoteles_index: (context) => HotelesScreen(),

    };
  }
}
