class Contacto {
  String? correo;
  String? numeroTelefono;
  String? facebook;
  String? instagram;
  String? sitioWeb;

  Contacto({
    required this.correo,
    required this.numeroTelefono,
    this.facebook,
    this.instagram,
    this.sitioWeb
  });

  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      correo: json['correo'],
      numeroTelefono: json['numeroTelefono'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      sitioWeb: json['sitioWeb']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'numeroTelefono': numeroTelefono,
      'facebook': facebook,
      'instagram': instagram,
      'sitioWeb': sitioWeb
    };
  }
}