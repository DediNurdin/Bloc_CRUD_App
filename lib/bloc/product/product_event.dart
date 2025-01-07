part of 'product_bloc.dart';

abstract class ProductEvent {}

abstract class ProductSearchEvent {}

abstract class ProductDetailEvent {}

abstract class ProductCategoriesEvent {}

abstract class ProductByCategoriesEvent {}

class GetProductEvent extends ProductEvent {}

class GetProductSearchEvent extends ProductSearchEvent {}

class GetProductDetailEvent extends ProductDetailEvent {}

class GetProductCategoriesEvent extends ProductCategoriesEvent {}

class GetProductByCategoriesEvent extends ProductByCategoriesEvent {
  final String category;

  GetProductByCategoriesEvent({required this.category});
}

class SortProductEvent extends ProductSearchEvent {
  final String type;
  SortProductEvent({required this.type});
}

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
  final GlobalKey wgtKey;

  AddCartEvent(
      {required this.userId,
      required this.date,
      required this.quantity,
      required this.products,
      required this.wgtKey});
}
