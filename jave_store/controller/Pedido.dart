//@dart=2.9
class Pedido {
  String id;
  String costo_envio;
  String metodo_envio;
  String comentario;
  String carritoID;

  Pedido(
      {this.id,
      this.costo_envio,
      this.metodo_envio,
      this.comentario,
      this.carritoID});
  @override
  String toString() {
    return "id:" + this.costo_envio + "  name:" + this.id;
  }

// Connected[{"id":,"cantidad":,"nombre":,"descripcion":","Precio":"estado":,"Categoriaid":,"Usuarioid":"1","imagen":null}
  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      id: json["id"],
      costo_envio: json["costo_envio"],
      metodo_envio: json["metodo_envio"],
      comentario: json["comentario"],
      carritoID: json["Carritoid"]);
}
