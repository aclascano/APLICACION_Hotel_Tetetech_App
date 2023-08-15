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
          'fotografia': hotel.fotografia,
          'nombre': hotel.nombre,
          'calificacion': hotel.calificacion,
          'ubicacion': hotel.ubicacion,
          'disponibilidad': habitacionDisponible,
          'precioBase': hotel.precioBase?.toDouble(),
        };
      }).toList();
    } catch (e) {
      print('Error al obtener la lista de hoteles: $e');
      return [];
    }
  }

  //Para ver un hotel con atributos detallados.

 Future<Hotel?> getHotelDetailByIndex(int index) async {
  List<Hotel> hotelesList = await _hotelService.getHotels();
  
  if (index >= 0 && index < hotelesList.length) {
    return hotelesList[index];
  } else {
    return null;
  }
}

  List<Hotel> filtrarPorUbicacion(
      List<Map<String, dynamic>> hotelesMap, String ubicacion) {

    List<Hotel> hoteles =
        hotelesMap.map((hotelMap) => Hotel.fromJson(hotelMap)).toList();
        

    return hoteles.where((hotel) => hotel.ubicacion == ubicacion).toList();
  }

  List<Hotel> filtrarPorPrecio(List<Map<String, dynamic>> hotelesMap,
    double minPrecio, double maxPrecio) {

  List<Hotel> hoteles = [];
  
  for (var hotelMap in hotelesMap) {
    Hotel? hotel = Hotel.fromJson(hotelMap);

    print('xddd');
    print(maxPrecio);
    print(hotel.precioBase);
    if (hotel != null && hotel.precioBase != null &&
        hotel.precioBase! >= minPrecio && hotel.precioBase! <= maxPrecio) {
      hoteles.add(hotel);
    }
    
  }

  return hoteles;
}


// Filtrar por disponibilidad

  List<Hotel> filtrarPorDisponibilidad(
      List<Map<String, dynamic>> hotelesMap, int cantidadHabitaciones) {

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
