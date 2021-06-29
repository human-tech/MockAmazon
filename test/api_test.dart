import 'package:amazon/productsAPI/parsers/product_parser.dart';
import 'package:amazon/productsAPI/product_client.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Test API Functionality', () async {
    final products = await RequestProducts().executeGet(ProductParser());
    expect(products.first.id, 1);
    expect(products.length, 20);
  });
}
