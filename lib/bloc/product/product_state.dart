part of 'product_bloc.dart';

abstract class ProductState {}

abstract class ProductSearchState {}

abstract class ProductDetailState {}

class ProductInitial extends ProductState {}

class ProductSearchInitial extends ProductSearchState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductLoading extends ProductState {}

class ProductSearchLoading extends ProductSearchState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess({
    required this.products,
  });
}

class ProductFailure extends ProductState {
  final String error;

  ProductFailure(this.error);
}

class ProductSortSuccess extends ProductSearchState {
  final List<Product> products;

  ProductSortSuccess({
    required this.products,
  });
}

class ProductSortFailure extends ProductSearchState {
  final String error;

  ProductSortFailure(this.error);
}

class ProductSearchSuccess extends ProductSearchState {
  final List<Product> products;

  ProductSearchSuccess({
    required this.products,
  });
}

class ProductSearchFailure extends ProductSearchState {
  final String error;

  ProductSearchFailure(this.error);
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

abstract class ProductByCategoriesState {}

class ProductByCategoriesInitial extends ProductByCategoriesState {}

class ProductByCategoriesLoading extends ProductByCategoriesState {}

class ProductByCategoriesSuccess extends ProductByCategoriesState {
  final List<Product> productByCategories;
  ProductByCategoriesSuccess({
    required this.productByCategories,
  });
}

abstract class ProductLimitState {}

class ProductLimitInitial extends ProductLimitState {}

class ProductLimitLoading extends ProductLimitState {}

class ProductLimitSuccess extends ProductLimitState {
  final List<Product> productLimit;
  ProductLimitSuccess({
    required this.productLimit,
  });
}

class ShowBottomSheetBuyProduct extends ProductDetailState {}

class ShowBottomSheetAddCartProduct extends ProductDetailState {}

class QuantityState {
  late final int quantity;
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

class AddCartSuccess extends ProductDetailState {
  final String message;
  final GlobalKey key;
  final int quantity;

  AddCartSuccess(this.message, this.key, this.quantity);
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
