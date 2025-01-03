import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../bloc/cart/cart_bloc.dart';
import '../../../models/cart_model.dart';
import '../../../utils/utils.dart';
import '../product/item/quantity_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                CupertinoIcons.chat_bubble_2,
              ))
        ],
      ),
      body: BlocProvider(
        create: (context) => CartBloc()..add(GetCartEvent()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: state.carts.length,
                        itemBuilder: (context, index) {
                          final cart = state.carts[index];
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      BlocProvider(
                                        create: (context) => CartCheckBloc(),
                                        child: BlocBuilder<CartCheckBloc,
                                            CartCheckState>(
                                          builder: (context, state) {
                                            return Checkbox(
                                              value: state.shopChecks[
                                                      cart.id.toString()] ??
                                                  false,
                                              onChanged: (_) {
                                                context
                                                    .read<CartCheckBloc>()
                                                    .add(ToggleShopCheck(
                                                        cart.id.toString()));
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Text(cart.id.toString())
                                    ],
                                  ),
                                  Column(
                                    children: cart.products.map((product) {
                                      return FutureBuilder<ProductDetail>(
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
                                              return ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                title: Text('Loading...',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                subtitle: Text('Loading...',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                leading: SizedBox(
                                                  height: 100,
                                                  width: 60,
                                                  child: Center(
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  ),
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                'Error loading product',
                                                style: TextStyle(fontSize: 12),
                                              );
                                            } else {
                                              final productDetail =
                                                  snapshot.data!;
                                              var totProdPrc =
                                                  productDetail.price *
                                                      product.quantity;
                                              return BlocProvider(
                                                create: (context) =>
                                                    QuantityCartBloc(totProdPrc,
                                                        product.quantity),
                                                child: BlocBuilder<
                                                    QuantityCartBloc,
                                                    QuantityCartState>(
                                                  builder: (context, state) {
                                                    final quantity = state
                                                            is QuantityCartUpdated
                                                        ? state.quantity
                                                        : product.quantity;

                                                    final totalPrice =
                                                        productDetail.price *
                                                            quantity;

                                                    return Dismissible(
                                                      key: Key(product.productId
                                                          .toString()),
                                                      background: Container(
                                                        color: Colors.red,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 16),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      child: ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        leading: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  CartCheckBloc(),
                                                              child: BlocBuilder<
                                                                  CartCheckBloc,
                                                                  CartCheckState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  return Checkbox(
                                                                    value: state.productChecks[product
                                                                            .productId
                                                                            .toString()] ??
                                                                        false,
                                                                    onChanged:
                                                                        (_) {
                                                                      context
                                                                          .read<
                                                                              CartCheckBloc>()
                                                                          .add(ToggleProductCheck(product
                                                                              .productId
                                                                              .toString()));
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 120,
                                                              width: 60,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                child: Image
                                                                    .network(
                                                                  productDetail
                                                                      .image,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        title: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Text(
                                                            productDetail.title,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              'USD $totalPrice',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                            const Spacer(),
                                                            QuantityWidget(
                                                                txtQauntity:
                                                                    quantity
                                                                        .toString(),
                                                                onPressIncrement:
                                                                    () {
                                                                  context
                                                                      .read<
                                                                          QuantityCartBloc>()
                                                                      .add(
                                                                          IncrementCartQuantity());
                                                                },
                                                                onPressDecrement:
                                                                    () {
                                                                  context
                                                                      .read<
                                                                          QuantityCartBloc>()
                                                                      .add(
                                                                          DecrementCartQuantity());
                                                                }),
                                                            const SizedBox(
                                                              width: 10,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          });
                                    }).toList(),
                                  )
                                ]),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                BlocProvider(
                                  create: (context) => CartCheckBloc(),
                                  child: BlocListener<CartCheckBloc,
                                          CartCheckState>(
                                      listener: (context, state) {},
                                      child: BlocBuilder<CartCheckBloc,
                                          CartCheckState>(
                                        builder: (context, state) {
                                          return Checkbox(
                                            value: state.isAllChecked,
                                            onChanged: (value) {
                                              context
                                                  .read<CartCheckBloc>()
                                                  .add(ToggleAllCheck(value!));
                                            },
                                          );
                                        },
                                      )),
                                ),
                                Text('All')
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: BlocProvider(
                              create: (context) => CartCheckBloc(),
                              child: BlocBuilder<CartCheckBloc, CartCheckState>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                        "Total: USD ${context.watch<CartCheckBloc>().state.totalPrice}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                  );
                                },
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                                height: double.infinity,
                                color: Colors.green,
                                child: Center(
                                    child: Text(
                                  'Check Out',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ))))
                      ],
                    ),
                  )
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}
