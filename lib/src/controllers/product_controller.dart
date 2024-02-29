import 'package:flutter/material.dart';
import 'package:oho_cart/src/models/product/product.dart';
import 'package:oho_cart/src/services/product_service.dart';

class ProductController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Product> products = [];
  ProductController() {
    getProducts();
  }

  Future<List<Product>> getProducts() async {
    setLoading(true);
    products = await ProductService.getProducts();
    setLoading(false);
    notifyListeners();
    return products;
  }

  Future<Product> getProduct(String id) async {
    setLoading(true);
    final product = await ProductService().getProduct(id);
    setLoading(false);
    notifyListeners();
    return product;
  }

  Future<List<Product>> searchProducts(String query) async {
    setLoading(true);
    products = await ProductService().searchProducts(query);
    setLoading(false);
    notifyListeners();
    return products;
  }
}
