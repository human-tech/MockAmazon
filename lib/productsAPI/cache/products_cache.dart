import 'dart:collection';
import 'package:amazon/productsAPI/models/product_model.dart';

class ProductCache {
  var _index = -1;

  final List<Product> _products;

  ProductCache(this._products);

  int get index => _index;
  set index(int value) {
    if ((value >= 0) && (value < _products.length)) {
      _index = value;
    } else {
      _index = -1;
    }
  }

  UnmodifiableListView<Product> get products =>
      UnmodifiableListView<Product>(_products);
}
