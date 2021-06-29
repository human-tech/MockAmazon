import 'package:amazon/productsAPI/models/product_model.dart';
import 'package:amazon/productsAPI/parsers/json_parser.dart';

class ProductParser extends JsonParser<List<Product>>
    with ListDecoder<List<Product>> {
  const ProductParser();

  @override
  Future<List<Product>> parseFromJson(String json) async {
    return decodeJsonList(json)
        .map((value) => Product.fromJson(value as Map<String, dynamic>))
        .toList();
  }
}
