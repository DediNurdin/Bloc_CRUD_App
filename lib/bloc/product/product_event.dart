part of 'product_bloc.dart';

abstract class ProductEvent {}

abstract class ProductCategoriesEvent {}

class GetProductEvent extends ProductEvent {}

class GetProductCategoriesEvent extends ProductCategoriesEvent {}

class ShowBottomSheetBuyProductEvent extends ProductEvent {}

abstract class QuantityEvent {}

class IncrementQuantity extends QuantityEvent {}

class DecrementQuantity extends QuantityEvent {}

abstract class LikeProductEvent {}

class LikedProductEvent extends LikeProductEvent {}
