import 'package:flutter/material.dart';
import 'package:oho_cart/src/services/cart_service.dart';

class CartController extends ChangeNotifier {
  CartController() {
    getCartItems();
  }
  int cartCount = 0;

  final List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    final CartService cartService = CartService();
    cartService.addToCart(product);
    cartItems.add(product);
    cartCount = cartItems.length;
    notifyListeners();
  }

  Future<void> getCartItems() async {
    final CartService cartService = CartService();
    final response = await cartService.getCart();
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['carts'];
      cartItems.clear();
      for (final Map<String, dynamic> item in data) {
        cartItems.add(item);
      }
      cartCount = cartItems.length;
      notifyListeners();
    }
  }

  void removeFromCart(Map<String, dynamic> product) {
    cartItems.remove(product);
    cartCount = cartItems.length;
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    cartCount = 0;
    notifyListeners();
  }

  void incrementItem(Map<String, dynamic> product) {
    final int index = cartItems.indexOf(product);
    cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decrementItem(Map<String, dynamic> product) {
    final int index = cartItems.indexOf(product);
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    for (final Map<String, dynamic> item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  int get totalItems {
    int total = 0;
    for (final Map<String, dynamic> item in cartItems) {
      total += int.parse(item['quantity']);
    }
    return total;
  }

  bool get isCartEmpty => cartItems.isEmpty;

  bool isItemInCart(Map<String, dynamic> product) {
    return cartItems.contains(product);
  }
}
