import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../../models/cart_model.dart';
import '../../utils/utils.dart';

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

class QuantityCartBloc extends Bloc<QuantityCartEvent, QuantityCartState> {
  final double productPrice;
  final int quantity;

  QuantityCartBloc(this.productPrice, this.quantity)
      : super(QuantityCartState(quantity: quantity, price: productPrice)) {
    on<IncrementCartQuantity>((event, emit) {
      emit(state.copyWith(
        quantity: state.quantity + 1,
        price: (state.quantity + 1) * productPrice,
      ));

      emit(QuantityCartUpdated(quantity: state.quantity, price: state.price));
    });

    on<DecrementCartQuantity>((event, emit) {
      if (state.quantity > 1) {
        emit(state.copyWith(
          quantity: state.quantity - 1,
          price: (state.quantity - 1) * productPrice,
        ));
      }
      emit(QuantityCartUpdated(quantity: state.quantity, price: state.price));
    });
  }
}

class CartCheckBloc extends Bloc<CartCheckEvent, CartCheckState> {
  CartCheckBloc()
      : super(CartCheckState(
          productChecks: {},
          shopChecks: {},
          isAllChecked: false,
          totalPrice: 0.0,
        )) {
    on<ToggleProductCheck>(_onToggleProductCheck);
    on<ToggleShopCheck>(_onToggleShopCheck);
    on<ToggleAllCheck>(_onToggleAllCheck);
  }

  void _onToggleProductCheck(
      ToggleProductCheck event, Emitter<CartCheckState> emit) {
    final productChecks = Map<String, bool>.from(state.productChecks);
    final shopChecks = Map<String, bool>.from(state.shopChecks);

    productChecks[event.productId] = !(productChecks[event.productId] ?? false);

    final shopId = _getShopIdByProductId(event.productId);
    final isShopChecked = _isShopFullyChecked(shopId, productChecks);
    shopChecks[shopId] = isShopChecked;

    final isAllChecked = _isAllChecked(shopChecks);

    final totalPrice = _calculateTotalPrice(productChecks);

    emit(state.copyWith(
      productChecks: productChecks,
      shopChecks: shopChecks,
      isAllChecked: isAllChecked,
      totalPrice: totalPrice,
    ));
    emit(CartCheckUpdated(
        productChecks: productChecks,
        shopChecks: shopChecks,
        isAllChecked: isAllChecked,
        totalPrice: totalPrice));
  }

  void _onToggleShopCheck(ToggleShopCheck event, Emitter<CartCheckState> emit) {
    final productChecks = Map<String, bool>.from(state.productChecks);
    final shopChecks = Map<String, bool>.from(state.shopChecks);

    shopChecks[event.shopId] = !(shopChecks[event.shopId] ?? false);

    final productIds = _getProductIdsByShopId(event.shopId);
    for (var productId in productIds) {
      productChecks[productId] = shopChecks[event.shopId]!;
    }

    final isAllChecked = _isAllChecked(shopChecks);

    final totalPrice = _calculateTotalPrice(productChecks);

    emit(state.copyWith(
      productChecks: productChecks,
      shopChecks: shopChecks,
      isAllChecked: isAllChecked,
      totalPrice: totalPrice,
    ));

    emit(CartCheckUpdated(
        productChecks: productChecks,
        shopChecks: shopChecks,
        isAllChecked: isAllChecked,
        totalPrice: totalPrice));
  }

  void _onToggleAllCheck(ToggleAllCheck event, Emitter<CartCheckState> emit) {
    final productChecks = Map<String, bool>.from(state.productChecks);
    final shopChecks = Map<String, bool>.from(state.shopChecks);

    for (var shopId in shopChecks.keys) {
      shopChecks[shopId] = event.isChecked;
    }
    for (var productId in productChecks.keys) {
      productChecks[productId] = event.isChecked;
    }

    final totalPrice = _calculateTotalPrice(productChecks);

    emit(state.copyWith(
      productChecks: productChecks,
      shopChecks: shopChecks,
      isAllChecked: event.isChecked,
      totalPrice: totalPrice,
    ));
    emit(CartCheckUpdated(
        productChecks: productChecks,
        shopChecks: shopChecks,
        isAllChecked: event.isChecked,
        totalPrice: totalPrice));
  }

  String _getShopIdByProductId(String productId) {
    return "shop_id";
  }

  List<String> _getProductIdsByShopId(String shopId) {
    return ["product_id1", "product_id2"];
  }

  bool _isShopFullyChecked(String shopId, Map<String, bool> productChecks) {
    final productIds = _getProductIdsByShopId(shopId);
    return productIds.every((productId) => productChecks[productId] ?? false);
  }

  bool _isAllChecked(Map<String, bool> shopChecks) {
    return shopChecks.values.every((isChecked) => isChecked);
  }

  double _calculateTotalPrice(Map<String, bool> productChecks) {
    double totalPrice = 0.0;

    productChecks.forEach((productId, isChecked) {
      if (isChecked) {
        totalPrice += _getProductPriceById(productId);
      }
    });

    return totalPrice;
  }

  double _getProductPriceById(String productId) {
    return 10000.0;
  }
}
