//@dart=2.9
class Producto {
  String descripcion;
  String nombre;
  String activo;
  String codigo;
  String precio;
  String cantidad;

  Producto({
    this.codigo,
    this.descripcion,
    this.nombre,
    this.activo,
    this.precio,
    this.cantidad,
  });
  @override
  String toString() {
    return "id:" + this.codigo + "  name:" + this.nombre;
  }

// Connected[{"id":,"cantidad":,"nombre":,"descripcion":","Precio":"estado":,"Categoriaid":,"Usuarioid":"1","imagen":null}
  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      codigo: json["id"],
      cantidad: json["cantidad"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      precio: json["Precio"],
      activo: json["estado"]);
}
