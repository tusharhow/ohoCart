import 'package:dio/dio.dart';
import 'package:oho_cart/src/constants/api_constants.dart';
import 'package:oho_cart/src/models/product/product.dart';

class ProductService {
  static final Dio _dio = Dio();

  static Future<List<Product>> getProducts() async {
    var response = await _dio.get(BASE_URL + PRODUCTS);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<dynamic> products = data['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProduct(String id) async {
    try {
      final Response response = await _dio.get(
        '$BASE_URL$PRODUCTS/$id',
      );
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final Response response = await _dio.get(
        '$BASE_URL$PRODUCTS/search?q=$query',
      );
      List<dynamic> products = response.data['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<Response> createProduct(Map<String, dynamic> product) async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/products',
        data: product,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> updateProduct(int id, Map<String, dynamic> product) async {
    try {
      final Response response = await _dio.put(
        'https://api.example.com/products/$id',
        data: product,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> deleteProduct(int id) async {
    try {
      final Response response = await _dio.delete(
        'https://api.example.com/products/$id',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> getCategories() async {
    try {
      final Response response = await _dio.get(
        'https://api.example.com/categories',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> getCategory(int id) async {
    try {
      final Response response = await _dio.get(
        'https://api.example.com/categories/$id',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> createCategory(Map<String, dynamic> category) async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/categories',
        data: category,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> updateCategory(int id, Map<String, dynamic> category) async {
    try {
      final Response response = await _dio.put(
        'https://api.example.com/categories/$id',
        data: category,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> deleteCategory(int id) async {
    try {
      final Response response = await _dio.delete(
        'https://api.example.com/categories/$id',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> searchCategories(String query) async {
    try {
      final Response response = await _dio.get(
        'https://api.example.com/categories/search?query=$query',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> getOrders() async {
    try {
      final Response response = await _dio.get(
        'https://api.example.com/orders',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> getOrder(int id) async {
    try {
      final Response response = await _dio.get(
        'https://api.example.com/orders/$id',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> createOrder(Map<String, dynamic> order) async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/orders',
        data: order,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> updateOrder(int id, Map<String, dynamic> order) async {
    try {
      final Response response = await _dio.put(
        'https://api.example.com/orders/$id',
        data: order,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
