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
