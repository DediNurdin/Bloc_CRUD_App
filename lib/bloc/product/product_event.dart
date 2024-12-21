part of 'product_bloc.dart';

abstract class ProductEvent {}

abstract class ProductDetailEvent {}

abstract class ProductCategoriesEvent {}

class GetProductEvent extends ProductEvent {}

class GetProductDetailEvent extends ProductDetailEvent {}

class GetProductCategoriesEvent extends ProductCategoriesEvent {}

class ShowBottomSheetBuyProductEvent extends ProductDetailEvent {}

class ShowBottomSheetAddCartProductEvent extends ProductDetailEvent {}

abstract class QuantityEvent {}

class IncrementQuantity extends QuantityEvent {}

class DecrementQuantity extends QuantityEvent {}

abstract class LikeProductEvent {}

class LikedProductEvent extends LikeProductEvent {}

class AddCartEvent extends ProductDetailEvent {
  final int userId;
  final String date;
  final int quantity;
  final List<ProductAddCart> products;

  AddCartEvent({
    required this.userId,
    required this.date,
    required this.quantity,
    required this.products,
  });
}
