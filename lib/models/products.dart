import 'package:notes/models/rating.dart';

class Products {
  late final String id;
  late final String name;
  late final String category;
  late final List images;
  late final num quantity;
  late final num price;
  late final String description;
  late final List<Rating>? rating;

  Products(
      {required this.id,
      required this.name,
      required this.category,
      required this.images,
      required this.quantity,
      required this.price,
      required this.description,
      required this.rating});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    description = json['description'];
    price = json['price'];
    images = json['images'];
    id = json['_id'];
    quantity = json['quantity'];
    rating = json['rating'] != null
        ? List<Rating>.from(json['rating'].map((e) {
            return Rating.fromJson(e);
          }))
        : null;
  }
}
