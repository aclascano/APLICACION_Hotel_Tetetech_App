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

    // Verificar si ya existe un hotel con el mismo nombre
    List<Hotel> hotelesExistentes = await _hotelService.getHotels();
    bool nombreRepetido =
        hotelesExistentes.any((h) => h.nombre == hotel.nombre);
    if (nombreRepetido) {
      throw Exception('Ya existe un hotel con el mismo nombre.');
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
          'precio': hotel.precioBase?.toDouble(),
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

  List<Hotel> filtrarPorUbicacion(
      List<Map<String, dynamic>> hotelesMap, String ubicacion) {
    // Convertir la lista de mapas a una lista de hoteles
    List<Hotel> hoteles =
        hotelesMap.map((hotelMap) => Hotel.fromJson(hotelMap)).toList();

    return hoteles.where((hotel) => hotel.ubicacion == ubicacion).toList();
  }

  List<Hotel> filtrarPorPrecio(List<Map<String, dynamic>> hotelesMap,
      double minPrecio, double maxPrecio) {
    // Convertir la lista de mapas a una lista de hoteles
    List<Hotel> hoteles =
        hotelesMap.map((hotelMap) => Hotel.fromJson(hotelMap)).toList();

    return hoteles
        .where((hotel) =>
            hotel.precioBase != null &&
            hotel.precioBase! >= minPrecio &&
            hotel.precioBase! <= maxPrecio)
        .toList();
  }

// Filtrar por disponibilidad

  List<Hotel> filtrarPorDisponibilidad(
      List<Map<String, dynamic>> hotelesMap, int cantidadHabitaciones) {
    // Convertir la lista de mapas a una lista de hoteles
    List<Hotel> hoteles =
        hotelesMap.map((hotelMap) => Hotel.fromJson(hotelMap)).toList();

    return hoteles.where((hotel) {
      int habitacionDisponible =
          (hotel.disponibilidad?.habitacionesFamiliares ?? 0) +
              (hotel.disponibilidad?.habitacionesGrupales ?? 0) +
              (hotel.disponibilidad?.habitacionesMatrimoniales ?? 0);
      return habitacionDisponible >= cantidadHabitaciones;
    }).toList();
  }
}
