import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  int get totalItems => _products.length;

  double get totalPrice {
    double total = 0;
    for (final product in _products) {
      total += product.preco;
    }
    return total;
  }

  void addProduct(Product product) {
    final cleanedName = product.nome.trim();
    if (cleanedName.isEmpty) {
      return;
    }

    _products.add(
      Product(
        nome: cleanedName,
        preco: product.preco,
      ),
    );
    notifyListeners();
  }

  void addProductByName(String nome, {double preco = 0.0}) {
    final cleanedName = nome.trim();
    if (cleanedName.isEmpty) {
      return;
    }

    _products.add(
      Product(nome: cleanedName, preco: preco),
    );
    notifyListeners();
  }

  void removeProduct(int index) {
    if (index < 0 || index >= _products.length) {
      return;
    }

    _products.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    notifyListeners();
  }
}
