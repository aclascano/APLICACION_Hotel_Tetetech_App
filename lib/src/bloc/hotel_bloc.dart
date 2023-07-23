import 'package:hotel_tetetech_app/src/models/contacto.dart';
import 'package:hotel_tetetech_app/src/models/disponibilidad.dart';
import 'package:hotel_tetetech_app/src/models/hotel.dart';
import 'package:hotel_tetetech_app/src/services/hotel_service.dart';

class HotelManager {
  final HotelService _hotelService = HotelService();

  bool isValidCalificacion(int? calificacion) {
    return calificacion != null && calificacion >= 1 && calificacion <= 5;
  }

  Future<void> addHotel(Hotel hotel) async {
    if (!isValidCalificacion(hotel.calificacion)) {
      throw Exception('La calificación debe estar entre 1 y 5.');
    }
    await _hotelService.addHotel(hotel);
  }

  //Para ver la lista de hoteles
  Future<List<Map<String, dynamic>>> getHotelGeneral() async {
    try {
      List<Hotel> hotelList = await _hotelService.getHotels();
      return hotelList.map((hotel) {
        int habitacionDisponible =
            (hotel.disponibilidad?.habitacionesFamiliares ?? 0) +
                (hotel.disponibilidad?.habitacionesGrupales ?? 0) +
                (hotel.disponibilidad?.habitacionesMatrimoniales ?? 0);

        return {
          'foto': hotel.fotografia,
          'nombre': hotel.nombre,
          'calificacion': hotel.calificacion,
          'ubicacion': hotel.ubicacion,
          'disponibilidad': habitacionDisponible,
          'precio': hotel.precioBase,
        };
      }).toList();
    } catch (e) {
      print('Error al obtener la lista de hoteles: $e');
      return [];
    }
  }

  //Para ver un hotel con atributos detallados.

  Future<Hotel?> getHotelDetail(String hotelId) async {
    try {
      return await _hotelService.getHotelById(hotelId);
    } catch (e) {
      print('Error al obtener el detalle del hotel: $e');
      return null;
    }
  }

  //Filtrar por Ubicación
  List<Hotel> filtrarPorUbicacion(List<Hotel> hoteles, String ubicacion) {
    return hoteles.where((hotel) => hotel.ubicacion == ubicacion).toList();
  }

  //Filtrar por precio

  List<Hotel> filtrarPorPrecio(
      List<Hotel> hoteles, double minPrecio, double maxPrecio) {
    return hoteles
        .where((hotel) =>
            hotel.precioBase! >= minPrecio && hotel.precioBase! <= maxPrecio)
        .toList();
  }

// Filtrar por disponibilidad

  List<Hotel> filtrarPorDisponibilidad(
      List<Hotel> hoteles, int cantidadHabitaciones) {
    return hoteles.where((hotel) {
      int habitacionDisponible =
          (hotel.disponibilidad?.habitacionesFamiliares ?? 0) +
              (hotel.disponibilidad?.habitacionesGrupales ?? 0) +
              (hotel.disponibilidad?.habitacionesMatrimoniales ?? 0);
      return habitacionDisponible >= cantidadHabitaciones;
    }).toList();
  }
}
