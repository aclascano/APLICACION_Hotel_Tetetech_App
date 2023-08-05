class Usuario {
  String? id;
  String? nombre;
  String? contrasena;
  String? correo;
  String? rol;

  Usuario({this.id, this.nombre, this.correo,this.contrasena, this.rol});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      contrasena: json['contrasena'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena, 
      'rol': rol,
    };
  }
}