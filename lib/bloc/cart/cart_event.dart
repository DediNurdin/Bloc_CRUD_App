part of 'cart_bloc.dart';

abstract class CartEvent {}

class GetCartEvent extends CartEvent {}

abstract class QuantityCartEvent {}

class IncrementCartQuantity extends QuantityCartEvent {}

class DecrementCartQuantity extends QuantityCartEvent {}

abstract class CartCheckEvent {}

class ToggleProductCheck extends CartCheckEvent {
  final String productId;
  ToggleProductCheck(this.productId);
}

class ToggleShopCheck extends CartCheckEvent {
  final String shopId;
  ToggleShopCheck(this.shopId);
}

class ToggleAllCheck extends CartCheckEvent {
  final bool isChecked;
  ToggleAllCheck(this.isChecked);
}
