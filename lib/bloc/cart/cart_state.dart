part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<Cart> carts;

  CartSuccess(this.carts);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}

class QuantityCartState {
  late final int quantity;
  final double price;

  QuantityCartState({required this.quantity, required this.price});

  QuantityCartState copyWith({int? quantity, double? price}) {
    return QuantityCartState(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

class QuantityCartUpdated extends QuantityCartState {
  QuantityCartUpdated({required super.quantity, required super.price});
}

class CartCheckState {
  final Map<String, bool> productChecks;
  final Map<String, bool> shopChecks;
  final bool isAllChecked;
  final double totalPrice;

  CartCheckState({
    required this.productChecks,
    required this.shopChecks,
    required this.isAllChecked,
    required this.totalPrice,
  });

  CartCheckState copyWith({
    Map<String, bool>? productChecks,
    Map<String, bool>? shopChecks,
    bool? isAllChecked,
    double? totalPrice,
  }) {
    return CartCheckState(
      productChecks: this.productChecks,
      shopChecks: this.shopChecks,
      isAllChecked: this.isAllChecked,
      totalPrice: this.totalPrice,
    );
  }
}

class CartCheckUpdated extends CartCheckState {
  CartCheckUpdated(
      {required super.productChecks,
      required super.shopChecks,
      required super.isAllChecked,
      required super.totalPrice});
}
