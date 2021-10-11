//@dart=2.9
class Carrito {
  String estado;
  String fecha;
  String id;
  String usuarioId;

  Carrito({
    this.estado,
    this.fecha,
    this.usuarioId,
    this.id,
  });
  @override
  String toString() {
    return "id:" + this.estado + "  name:" + this.id;
  }

// Connected[{"id":,"cantidad":,"nombre":,"descripcion":","Precio":"estado":,"Categoriaid":,"Usuarioid":"1","imagen":null}
  factory Carrito.fromJson(Map<String, dynamic> json) => Carrito(
        id: json["id"],
        usuarioId: json["Usuarioid"],
        estado: json["estado"],
        fecha: json["fecha"],
      );
}
