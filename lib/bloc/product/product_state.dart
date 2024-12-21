part of 'product_bloc.dart';

abstract class ProductState {}

abstract class ProductDetailState {}

class ProductInitial extends ProductState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductLoading extends ProductState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess({
    required this.products,
  });
}

class ProductDetailSuccess extends ProductDetailState {}

abstract class ProductCategoriesState {}

class ProductCategoriesInitial extends ProductCategoriesState {}

class ProductCategoriesLoading extends ProductCategoriesState {}

class ProductCategoriesSuccess extends ProductCategoriesState {
  final List<dynamic> categories;
  ProductCategoriesSuccess({
    required this.categories,
  });
}

class ShowBottomSheetBuyProduct extends ProductDetailState {}

class ShowBottomSheetAddCartProduct extends ProductDetailState {}

class QuantityState {
  final int quantity;
  final double price;

  QuantityState({required this.quantity, required this.price});

  QuantityState copyWith({int? quantity, double? price}) {
    return QuantityState(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

class QuantityUpdated extends QuantityState {
  QuantityUpdated({required super.quantity, required super.price});
}

class AddCartLoading extends ProductDetailState {}

class AddCartSuccess extends ProductDetailState {
  final String message;

  AddCartSuccess(this.message);
}

class AddCartError extends ProductDetailState {
  final String error;

  AddCartError(this.error);
}

class LikeProductState {
  final bool isLiked;
  LikeProductState({required this.isLiked});

  LikeProductState copyWith({bool? isLiked}) {
    return LikeProductState(
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class LikeProductUpdated extends LikeProductState {
  LikeProductUpdated({required super.isLiked});
}
