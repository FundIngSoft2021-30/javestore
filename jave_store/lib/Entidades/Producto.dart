//@dart=2.9
import 'dart:convert';

List<Producto> ProductoFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

class Producto {
  String description;
  String category;
  String name;
  bool available;
  double price;
  int rate;
  int quantity;
  String image;

  Producto({
    this.image,
    this.description,
    this.name,
    this.available,
    this.price,
    this.category,
    this.rate,
    this.quantity,
  });
  @override
  String toString() {
    return 'Producto{description: $description, category: $category, name: $name, available: $available, price: $price, rate: $rate, quantity: $quantity, image: $image}';
  }

  Map<String, dynamic> toJson() => {
        'available': available,
        'image': image,
        'description': description,
        'price': price,
        'category': category,
        'rate': rate,
        'quantity': quantity,
      };
  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      quantity: json["quantity"],
      category: json["category"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      rate: json["rate"],
      image: json["image"],
      available: json["available"]);
}
