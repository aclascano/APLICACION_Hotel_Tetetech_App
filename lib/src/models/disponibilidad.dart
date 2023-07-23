class Disponibilidad {
  int? habitacionesMatrimoniales;
  int? habitacionesFamiliares;
  int? habitacionesGrupales;
  
  // Precios para cada tipo de habitación
  double? precioMatrimonial;
  double? precioFamiliar;
  double? precioGrupal;

  Disponibilidad({
    required this.habitacionesMatrimoniales,
    required this.habitacionesFamiliares,
    required this.habitacionesGrupales,
    required this.precioMatrimonial,
    required this.precioFamiliar,
    required this.precioGrupal,
  });

  factory Disponibilidad.fromJson(Map<String, dynamic> json) {
    return Disponibilidad(
      habitacionesMatrimoniales: json['habitacionesMatrimoniales'],
      habitacionesFamiliares: json['habitacionesFamiliares'],
      habitacionesGrupales: json['habitacionesGrupales'],
      precioMatrimonial: json['precioMatrimonial'],
      precioFamiliar: json['precioFamiliar'],
      precioGrupal: json['precioGrupal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'habitacionesMatrimoniales': habitacionesMatrimoniales,
      'habitacionesFamiliares': habitacionesFamiliares,
      'habitacionesGrupales': habitacionesGrupales,
      'precioMatrimonial': precioMatrimonial,
      'precioFamiliar': precioFamiliar,
      'precioGrupal': precioGrupal,
    };
  }
}
