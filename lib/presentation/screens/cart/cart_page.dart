import 'dart:convert';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../models/cart_model.dart';
import '../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocProvider(
        create: (context) => CartBloc()..add(GetCartEvent()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartSuccess) {
              return ListView.builder(
                itemCount: state.carts.length,
                itemBuilder: (context, index) {
                  final cart = state.carts[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: cart.products.map((product) {
                              return ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FutureBuilder<ProductDetail>(
                                      future: http
                                          .get(Uri.parse(
                                              '${Utils.baseUrlFakeApi}/products/${product.productId}'))
                                          .then((response) {
                                        if (response.statusCode == 200) {
                                          return ProductDetail.fromJson(
                                              json.decode(response.body));
                                        } else {
                                          throw Exception(
                                              'Failed to load product detail');
                                        }
                                      }),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CupertinoActivityIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Icon(
                                                  Icons.hide_image_rounded));
                                        } else {
                                          final productDetail = snapshot.data!;
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: SizedBox(
                                              height: 70,
                                              width: 60,
                                              child: Image.network(
                                                productDetail.image,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                title: FutureBuilder<ProductDetail>(
                                  future: http
                                      .get(Uri.parse(
                                          '${Utils.baseUrlFakeApi}/products/${product.productId}'))
                                      .then((response) {
                                    if (response.statusCode == 200) {
                                      return ProductDetail.fromJson(
                                          json.decode(response.body));
                                    } else {
                                      throw Exception(
                                          'Failed to load product detail');
                                    }
                                  }),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('Loading...');
                                    } else if (snapshot.hasError) {
                                      return Text('Error loading product');
                                    } else {
                                      final productDetail = snapshot.data!;
                                      return Text(
                                        productDetail.title,
                                        style: TextStyle(color: Colors.green),
                                      );
                                    }
                                  },
                                ),
                                subtitle: Text('Quantity: ${product.quantity}'),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
