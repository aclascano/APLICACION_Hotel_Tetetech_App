import 'contacto.dart';
import 'disponibilidad.dart';

class Hotel {
  String? nombre;
  String? ubicacion;
  int? calificacion;
  double?precioBase;
  String? descripcion;
  List<String>? servicios; // Lista de servicios disponibles
  Disponibilidad? disponibilidad; // Objeto de la clase Disponibilidad
  Contacto? contacto;
  String? fotografia;

  Hotel({
    required this.nombre,
    required this.ubicacion,
    required this.calificacion,
    required this.precioBase,
    required this.descripcion,
    required this.servicios,
    required this.disponibilidad,
    required this.contacto,
    required this.fotografia
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
  return Hotel(
    nombre: json['nombre'],
    ubicacion: json['ubicacion'],
    calificacion: json['calificacion'],
    precioBase: json['precioBase'],
    descripcion: json['descripcion'],
    servicios: json['servicios'] != null ? List<String>.from(json['servicios']) : null,
    disponibilidad: json['disponibilidad'] is Map<String, dynamic> ? Disponibilidad.fromJson(json['disponibilidad']) : null,
    contacto: json['contacto'] is Map<String, dynamic> ? Contacto.fromJson(json['contacto']) : null,
    fotografia: json['fotografia']
  );
}




  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'ubicacion': ubicacion,
      'calificacion': calificacion,
      'precioBase':precioBase,
      'descripcion': descripcion,
      'servicios': servicios,
      'disponibilidad': disponibilidad?.toJson(),
      'contacto': contacto?.toJson(),
      'fotografia': fotografia
    };
  }
}