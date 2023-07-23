import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hotel.dart';


class HotelService {
  final CollectionReference hotelsCollection = FirebaseFirestore.instance.collection('hotels');

  // Método para obtener todos los hoteles
  Future<List<Hotel>> getHotels() async {
    try {
      QuerySnapshot querySnapshot = await hotelsCollection.get();
      return querySnapshot.docs.map((doc) => Hotel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error al obtener los hoteles: $e');
      return [];
    }
  }
  
  Future<Hotel?> getHotelById(String hotelId) async {
    try {
      DocumentSnapshot documentSnapshot = await hotelsCollection.doc(hotelId).get();
      if (documentSnapshot.exists) {
        return Hotel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener el hotel por ID: $e');
      return null;
    }
  }

  // Método para agregar un nuevo hotel
  Future<void> addHotel(Hotel hotel) async {
    try {
      // Utiliza el método doc() para especificar el nombre del documento
      // documentId debe ser un String único para evitar conflictos
      await hotelsCollection.add(hotel.toJson());
    } catch (e) {
      print('Error al agregar el hotel: $e');
    }
  }

  // Método para actualizar un hotel existente
  Future<void> updateHotel(String id, Hotel hotel) async {
    try {
      await hotelsCollection.doc(id).update(hotel.toJson());
    } catch (e) {
      print('Error al actualizar el hotel: $e');
    }
  }

  // Método para eliminar un hotel
  Future<void> deleteHotel(String id) async {
    try {
      await hotelsCollection.doc(id).delete();
    } catch (e) {
      print('Error al eliminar el hotel: $e');
    }
  }
}