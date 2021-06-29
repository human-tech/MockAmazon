import 'package:amazon/productsAPI/parsers/json_parser.dart';
import 'package:dio/dio.dart';

class RequestProducts {
  static const String _url = "https://fakestoreapi.com/products";

  const RequestProducts();

  static final _client = Dio();

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    final response = await _client.get<String>(_url);
    return parser.parseFromJson(response.data.toString());
  }
}
