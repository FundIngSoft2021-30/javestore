//@dart=2.9
class ProductoxCarrito {
  String idProducto;
  String nombre;
  String cantidad;
  String precio;
  String imagen;
  String carritoID;
  ProductoxCarrito({
    this.idProducto,
    this.nombre,
    this.precio,
    this.cantidad,
    this.imagen,
    this.carritoID,
  });
  @override
  String toString() {
    return "nombre:" +
        this.nombre +
        "precio:" +
        this.precio +
        "cantidad:" +
        this.cantidad;
  }

  factory ProductoxCarrito.fromJson(Map<String, dynamic> json) =>
      ProductoxCarrito(
          cantidad: json["cantidad"],
          nombre: json["producto"],
          precio: json["precio"],
          imagen: json["imagen"],
          idProducto: json["idProducto"],
          carritoID: json["carritoID"]);
}
