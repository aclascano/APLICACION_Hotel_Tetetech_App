import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/hotelcontacto_data.dart';
import '../data/hoteldisponibilidad_data.dart';
import '../data/hotelfotografia_data.dart';
import '../data/hotelinfo_data.dart';
import '../screens/añadir_hotel.dart';
import '../services/imagenes_service.dart';

class FotografiaForm extends StatefulWidget {
  final Hotelinfo info;
  final HotelFotografia fotografia;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final AgregarHotelScreen agregarHotelScreen;

  FotografiaForm(
      {required this.info,
      required this.disponibilidad,
      required this.contacto,
      required this.fotografia,
      required this.agregarHotelScreen});

  @override
  _FotografiaFormState createState() => _FotografiaFormState();
}

class _FotografiaFormState extends State<FotografiaForm> {
  final TextEditingController urlFotografiaController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late ImageUploadService _imageUploadService;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _imageUploadService = ImageUploadService();
  }

  Future<void> _selectImage() async {
    final XFile? imageFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _selectedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_selectedImage != null) {
      String? downloadUrl =
          await _imageUploadService.uploadImage(_selectedImage!);
      if (downloadUrl != null) {
        setState(() {
          widget.fotografia.fotografia = downloadUrl;
          urlFotografiaController.text = downloadUrl;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Imagen subida con éxito')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al subir la imagen')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Text('Paso 4. Sube la foto del hotel'),
            SizedBox(height: 16),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            TextField(
              controller: urlFotografiaController,
              onChanged: (value) => widget.fotografia.fotografia = value,
              decoration: InputDecoration(labelText: 'URL de la Fotografía'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Seleccionar imagen'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _uploadImage(context),
              child: Text('Cargar imagen'),
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para retroceder a la pantalla anterior
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 240, 193,
                        51), // Cambia el color de fondo del botón
                    onPrimary:
                        Colors.black, // Cambia el color del texto del botón
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Cambia el radio de borde del botón
                    ),
                  ),
                  child: Text('Retroceder'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Nombre del hotel: ${widget.info.nombre}');
                    print('Ubicación del hotel: ${widget.info.ubicacion}');
                    print('Calificación del hotel: ${widget.info.calificacion}');
                    print('Precio Base: ${widget.info.precioBase}');
                    print('Descripcion: ${widget.info.descripcion}');
                    print('Servicios ${widget.info.servicios}');
                    print(
                        'Habitacion M: ${widget.disponibilidad.habitacionesMatrimoniales}');
                    print(
                        'Habitacion F: ${widget.disponibilidad.habitacionesFamiliares}');
                    print(
                        'Habitacion G: ${widget.disponibilidad.habitacionesGrupales}');
                    print('Precio M: ${widget.disponibilidad.precioMatrimonial}');
                    print('Precio F: ${widget.disponibilidad.precioFamiliar}');
                    print('Precio G: ${widget.disponibilidad.habitacionesGrupales}');
                    print('Fotografia: ${widget.fotografia.fotografia}');
                  },
                  child: Text('Guardar Nuevo Hotel'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 119, 217,
                        43), // Cambia el color de fondo del botón
                    onPrimary:
                        Colors.black, // Cambia el color del texto del botón
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Cambia el radio de borde del botón
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
