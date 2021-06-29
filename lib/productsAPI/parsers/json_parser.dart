import 'dart:convert';

abstract class JsonParser<T> {
  const JsonParser();

  Future<T> parseFromJson(String json);
}

mixin ListDecoder<T> on JsonParser<T> {
  List<dynamic> decodeJsonList(String json) =>
      jsonDecode(json) as List<dynamic>;
}
