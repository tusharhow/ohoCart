import 'package:dio/dio.dart';
import 'package:oho_cart/src/constants/api_constants.dart';

class CartService {
  final Dio _dio = Dio();

  Future<Response> getCart() async {
    try {
      final Response response = await _dio.get(
        BASE_URL + CARTS,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> addToCart(Map<String, dynamic> product) async {
    try {
      final Response response = await _dio.post(
        BASE_URL + ADD_CART,
        options: Options(
          headers: {
            'userId': '1',
            'products': product,
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
