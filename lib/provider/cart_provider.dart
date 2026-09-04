import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // State Management through Provider package.
  final Map<String, dynamic> _quantities = {};
  // returns the quantities selected for specific product identified through [productId].
  int getQuantities(String productId) => _quantities[productId] ?? 1;

  void incrementQuantity(String productId) {
    _quantities[productId] = getQuantities(productId) + 1;
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    if (getQuantities(productId) > 1) {
      _quantities[productId] = getQuantities(productId) - 1;
      notifyListeners();
    }
  }

  // Multiplies the current product price by quantity selected.
  double calculateTotal(String productId, double price) =>
      price * getQuantities(productId);

  // returns Total price, eg. total products and their quantities.
  double getCartTotal(List<Map<String, dynamic>> cart) {
    double total = 0;
    for (var product in cart) {
      total += calculateTotal(product['id'].toString(), product['price']);
    }
    return total;
  }
}
