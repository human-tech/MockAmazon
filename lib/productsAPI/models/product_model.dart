import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;

  const Product(this.id, this.title, this.description, this.price,
      this.category, this.image);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
