class Propietarios {
  List<Propietario> items = new List();

  Propietarios();
  Propietarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final propietario = new Propietario.fromJsonMap(item);
      items.add(propietario);
    }
  }
}

class Propietario {
  int id;

  int tipoPropietario;
  String nombres;
  String apellidoPaterno;
  String apellidoMaterno;
  String celular;

  Propietario({
    this.id,
    this.tipoPropietario,
    this.nombres,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.celular,
  });

  Propietario.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    tipoPropietario = json['tipo_propietario'];
    nombres = json['nombres'];
    apellidoPaterno = json['apellido_paterno'];
    apellidoMaterno = json['apellido_materno'];
    celular = json['celular'];
  }
}
