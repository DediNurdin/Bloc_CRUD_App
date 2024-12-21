import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../models/cart_model.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final userId = await Utils.getUser();
        final response = await http
            .get(Uri.parse('${Utils.baseUrlFakeApi}/carts/user/$userId'));
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          final carts = await Future.wait(jsonData.map((data) async {
            final cart = Cart.fromJson(data);
            final productsWithDetails =
                await Future.wait(cart.products.map((product) async {
              final productResponse = await http.get(Uri.parse(
                  '${Utils.baseUrlFakeApi}/products/${product.productId}'));
              if (productResponse.statusCode == 200) {
                final productDetail =
                    ProductDetail.fromJson(json.decode(productResponse.body));
                return MapEntry(product, productDetail);
              } else {
                throw Exception('Failed to fetch product details');
              }
            }));
            return Cart(
              id: cart.id,
              userId: cart.userId,
              date: cart.date,
              products: productsWithDetails.map((entry) => entry.key).toList(),
            );
          }));
          emit(CartSuccess(carts));
        } else {
          emit(CartError('Failed to fetch carts: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(CartError('An error occurred: $e'));
      }
    });
  }
}
