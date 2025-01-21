import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../bloc/cart/cart_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/cart_model.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../bottom_navigation/bottom_nav_page.dart';
import '../bottom_navigation/main_menu.dart';
import '../product/item/quantity_widget.dart';
import '../product/recomended_page.dart';

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
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  CupertinoIcons.heart,
                )),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    elevation: 0,
                    shape: BeveledRectangleBorder(),
                    builder: (context) => MainMenu());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Icon(
                  CupertinoIcons.line_horizontal_3,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverList.list(children: [
                    BlocProvider(
                      create: (context) => CartBloc()..add(GetCartEvent()),
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartLoading) {
                            return SizedBox(
                              height: 70,
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (state is CartSuccess) {
                            if (state.carts.isEmpty) {
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Assets.icons.emptyCart
                                              .image(height: 100, width: 70),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Wow, your shopping cart is empty',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                'Come on, fill it with your dream items',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Utils.isDarkMode(
                                                            context)
                                                        ? Colors.white
                                                            .withValues(
                                                                alpha: 0.5)
                                                        : Colors.black
                                                            .withValues(
                                                                alpha: 0.5)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        width: double.infinity,
                                        child: Utils.buttonWigget(() {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationPage(
                                                initialIndex: 0,
                                              ),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                            Text(
                                              'Start Shopping',
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            false),
                                      )
                                    ],
                                  ));
                            } else {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.carts.length,
                                itemBuilder: (context, index) {
                                  final cart = state.carts[index];
                                  return Utils.customColumn(
                                    context,
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            BlocProvider(
                                              create: (context) =>
                                                  CartCheckBloc(),
                                              child: BlocBuilder<CartCheckBloc,
                                                  CartCheckState>(
                                                builder: (context, state) {
                                                  return Checkbox(
                                                    value: state.shopChecks[cart
                                                            .id
                                                            .toString()] ??
                                                        false,
                                                    onChanged: (_) {
                                                      context
                                                          .read<CartCheckBloc>()
                                                          .add(ToggleShopCheck(
                                                              cart.id
                                                                  .toString()));
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Text(cart.id.toString())
                                          ],
                                        ),
                                        Column(
                                          children:
                                              cart.products.map((product) {
                                            return FutureBuilder<ProductDetail>(
                                                future: http
                                                    .get(Uri.parse(
                                                        '${Utils.baseUrlFakeApi}/products/${product.productId}'))
                                                    .then((response) {
                                                  if (response.statusCode ==
                                                      200) {
                                                    return ProductDetail
                                                        .fromJson(json.decode(
                                                            response.body));
                                                  } else {
                                                    throw Exception(
                                                        'Failed to load product detail');
                                                  }
                                                }),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SkeletonWidget
                                                        .listSkeleton(
                                                            context, false, 1);
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                      'Error loading product',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    );
                                                  } else {
                                                    final productDetail =
                                                        snapshot.data!;
                                                    var totProdPrc =
                                                        productDetail.price *
                                                            product.quantity;
                                                    return BlocProvider(
                                                      create: (context) =>
                                                          QuantityCartBloc(
                                                              totProdPrc,
                                                              product.quantity),
                                                      child: BlocBuilder<
                                                          QuantityCartBloc,
                                                          QuantityCartState>(
                                                        builder:
                                                            (context, state) {
                                                          final quantity = state
                                                                  is QuantityCartUpdated
                                                              ? state.quantity
                                                              : product
                                                                  .quantity;

                                                          final totalPrice =
                                                              productDetail
                                                                      .price *
                                                                  quantity;

                                                          return ListTile(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            leading: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
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
                                                                        value: state.productChecks[product.productId.toString()] ??
                                                                            false,
                                                                        onChanged:
                                                                            (_) {
                                                                          context
                                                                              .read<CartCheckBloc>()
                                                                              .add(ToggleProductCheck(product.productId.toString()));
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
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      child: Utils.imageNetwork(
                                                                          context,
                                                                          productDetail
                                                                              .image,
                                                                          double
                                                                              .infinity)),
                                                                )
                                                              ],
                                                            ),
                                                            title: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10,
                                                              ),
                                                              child: Text(
                                                                productDetail
                                                                    .title,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            subtitle: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'USD $totalPrice',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .green),
                                                                ),
                                                                const Spacer(),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: QuantityWidget(
                                                                      isCart: true,
                                                                      txtQauntity: quantity.toString(),
                                                                      onPressIncrement: () {
                                                                        context
                                                                            .read<QuantityCartBloc>()
                                                                            .add(IncrementCartQuantity());
                                                                      },
                                                                      onPressDecrement: () {
                                                                        context
                                                                            .read<QuantityCartBloc>()
                                                                            .add(DecrementCartQuantity());
                                                                      }),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }
                                                });
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          } else if (state is CartError) {
                            return Center(child: Text(state.message));
                          }
                          return Center(child: Text('No data'));
                        },
                      ),
                    ),
                    recomended(1)
                  ]),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => CartBloc()..add(GetCartEvent()),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartSuccess) {
                    return buttonCheckOut(state.carts.isEmpty ? false : true);
                  }
                  return Container();
                },
              ),
            )
          ],
        ));
  }
}

Widget recomended(int index) {
  return RecomendedPage(
    isCart: true,
  );
}

Widget buttonCheckOut(bool visibleCheckOut) {
  return Visibility(
    visible: visibleCheckOut,
    child: Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.1))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    BlocProvider(
                      create: (context) => CartCheckBloc(),
                      child: BlocListener<CartCheckBloc, CartCheckState>(
                          listener: (context, state) {},
                          child: BlocBuilder<CartCheckBloc, CartCheckState>(
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
                            "USD ${context.watch<CartCheckBloc>().state.totalPrice}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                      );
                    },
                  ),
                )),
            Expanded(
                flex: 3,
                child: Utils.buttonWigget(
                    () {},
                    Text(
                      'Check Out',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    false))
          ],
        ),
      ),
    ),
  );
}
