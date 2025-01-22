import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../models/product_model.dart';
import '../../utils/utils.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetAllProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await http.get(
          Uri.parse('${Utils.baseUrlFakeApi}/products'),
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(ProductSuccess(products: productFromJson(response.body)));
        } else {
          emit(ProductFailure('An error occurred: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(ProductFailure('An error occurred: $e'));
      }
    });
  }
}

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductSearchBloc() : super(ProductSearchInitial()) {
    on<GetProductSearchEvent>((event, emit) async {
      emit(ProductSearchLoading());
      try {
        final response = await http.get(
          Uri.parse('${Utils.baseUrlFakeApi}/products'),
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(ProductSearchSuccess(products: productFromJson(response.body)));
        } else {
          emit(ProductSearchFailure(
              'An error occurred: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(ProductSearchFailure('An error occurred: $e'));
      }
    });
  }
}

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<GetProductDetailEvent>((event, emit) async {
      emit(ProductDetailLoading());
      emit(ProductDetailSuccess());
    });

    on<ShowBottomSheetBuyProductEvent>((event, emit) {
      emit(ShowBottomSheetBuyProduct());
      add(GetProductDetailEvent());
    });

    on<ShowBottomSheetAddCartProductEvent>((event, emit) {
      emit(ShowBottomSheetAddCartProduct());
      add(GetProductDetailEvent());
    });

    on<AddCartEvent>((event, emit) async {
      emit(AddCartLoading());
      try {
        final response = await http.post(
          Uri.parse('${Utils.baseUrlFakeApi}/carts'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userId': event.userId,
            'date': event.date,
            'products': event.products.map((product) {
              return {
                'productId': product.id,
                'quantity': event.quantity,
              };
            }).toList(),
          }),
        );

        if (response.statusCode == 200) {
          emit(AddCartSuccess(
              'Cart successfully added', event.wgtKey, event.quantity));
          add(GetProductDetailEvent());
        } else {
          emit(AddCartError('Failed to add cart: ${response.reasonPhrase}'));
          add(GetProductDetailEvent());
        }
      } catch (e) {
        emit(AddCartError('An error occurred: $e'));
        add(GetProductDetailEvent());
      }
    });
  }
}

class ProductCategoriesBloc
    extends Bloc<ProductCategoriesEvent, ProductCategoriesState> {
  ProductCategoriesBloc() : super(ProductCategoriesInitial()) {
    on<GetProductCategoriesEvent>((event, emit) async {
      emit(ProductCategoriesLoading());
      try {
        final response = await http.get(
          Uri.parse('${Utils.baseUrlFakeApi}/products/categories'),
          headers: {
            "Content-Type": "application/json",
          },
        );

        List<dynamic> jsonData = jsonDecode(response.body);
        emit(ProductCategoriesSuccess(categories: jsonData));
      } catch (e) {
        emit(ProductCategoriesError(e.toString()));
      }
    });
  }
}

class ProductByCategoriesBloc
    extends Bloc<ProductByCategoriesEvent, ProductByCategoriesState> {
  ProductByCategoriesBloc() : super(ProductByCategoriesInitial()) {
    on<GetProductByCategoriesEvent>((event, emit) async {
      emit(ProductByCategoriesLoading());
      final response = await http.get(
        Uri.parse(
            '${Utils.baseUrlFakeApi}/products/category/${event.category}'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      emit(ProductByCategoriesSuccess(
          productByCategories: productFromJson(response.body)));
    });
  }
}

class ProductLimitBloc extends Bloc<ProductLimitEvent, ProductLimitState> {
  ProductLimitBloc() : super(ProductLimitInitial()) {
    on<GetProductLimitEvent>((event, emit) async {
      emit(ProductLimitLoading());
      final response = await http.get(
        Uri.parse('${Utils.baseUrlFakeApi}/products?limit=7'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      emit(ProductLimitSuccess(productLimit: productFromJson(response.body)));
    });
  }
}

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  final double productPrice;

  QuantityBloc(this.productPrice)
      : super(QuantityState(quantity: 1, price: productPrice)) {
    on<IncrementQuantity>((event, emit) {
      emit(state.copyWith(
        quantity: state.quantity + 1,
        price: (state.quantity + 1) * productPrice,
      ));

      emit(QuantityUpdated(quantity: state.quantity, price: state.price));
    });

    on<DecrementQuantity>((event, emit) {
      if (state.quantity > 1) {
        emit(state.copyWith(
          quantity: state.quantity - 1,
          price: (state.quantity - 1) * productPrice,
        ));
      }
      emit(QuantityUpdated(quantity: state.quantity, price: state.price));
    });
  }
}

class LikeProductBloc extends Bloc<LikeProductEvent, LikeProductState> {
  final bool isLiked;

  LikeProductBloc(this.isLiked)
      : super(LikeProductState(
          isLiked: false,
        )) {
    on<LikedProductEvent>((event, emit) {
      if (state.isLiked == false) {
        emit(state.copyWith(
          isLiked: true,
        ));
        emit(LikeProductUpdated(isLiked: true));
      } else if (state.isLiked == true) {
        emit(state.copyWith(
          isLiked: false,
        ));
        emit(LikeProductUpdated(isLiked: false));
      }
    });
  }
}
