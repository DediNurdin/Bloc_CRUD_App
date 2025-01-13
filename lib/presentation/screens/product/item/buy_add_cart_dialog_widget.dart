import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/product/product_bloc.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/utils.dart';
import 'detail_product_src_widget.dart';
import 'quantity_widget.dart';

class BuyAddCartDialogWidget extends StatefulWidget {
  const BuyAddCartDialogWidget({
    super.key,
    required this.product,
    required this.title,
  });

  final Product product;
  final String title;

  @override
  State<BuyAddCartDialogWidget> createState() => _BuyAddCartDialogWidgetState();
}

class _BuyAddCartDialogWidgetState extends State<BuyAddCartDialogWidget> {
  final GlobalKey widgetKey = GlobalKey();
  int cartQuantityItems = 1;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  DateTime today = DateTime.now();
  String dateStr = '';
  int? userId;

  Future<void> initialize() async {
    userId = await Utils.getUser();
    setState(() {
      dateStr = "${today.year}-${today.month}-${today.day}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
        BlocProvider(
            create: (context) => QuantityBloc(widget.product.price),
            child: BlocBuilder<QuantityBloc, QuantityState>(
                builder: (context, state) {
              cartQuantityItems = state is QuantityUpdated ? state.quantity : 1;
              final totalPrice = widget.product.price * cartQuantityItems;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              key: widgetKey,
                              margin: const EdgeInsets.only(right: 10),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  widget.product.image,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const SizedBox(
                                      height: 100,
                                      child: Icon(
                                        Icons.image,
                                        size: 40,
                                        color: Colors.green,
                                      ),
                                    );
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.green,
                                          strokeWidth: 1.5,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    elevation: 0,
                                    shape: BeveledRectangleBorder(),
                                    builder: (context) =>
                                        DetailProductSrcWidget(
                                          product: widget.product,
                                        ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 10,
                                ),
                                padding: const EdgeInsets.all(5),
                                height: 100,
                                width: 100,
                                alignment: Alignment.topRight,
                                child: Icon(
                                  CupertinoIcons.fullscreen,
                                  size: 15,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.title,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'USD ${totalPrice.toString()}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ))
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Quantity',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                            const Spacer(),
                            QuantityWidget(
                                isCart: false,
                                txtQauntity: cartQuantityItems.toString(),
                                colorTxt: Colors.green,
                                onPressIncrement: () {
                                  context
                                      .read<QuantityBloc>()
                                      .add(IncrementQuantity());
                                },
                                onPressDecrement: () {
                                  context
                                      .read<QuantityBloc>()
                                      .add(DecrementQuantity());
                                }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Utils.buttonWigget(() {
                        widget.title == 'Buy'
                            ? Navigator.pop(context)
                            : context.read<ProductDetailBloc>().add(
                                AddCartEvent(
                                    userId: userId!,
                                    date: dateStr,
                                    quantity: cartQuantityItems,
                                    products: [
                                      ProductAddCart(
                                          id: widget.product.id,
                                          quantity: cartQuantityItems)
                                    ],
                                    wgtKey: widgetKey));
                      },
                          widget.title == 'Buy'
                              ? Text(widget.title)
                              : BlocBuilder<ProductDetailBloc,
                                  ProductDetailState>(
                                  builder: (context, state) {
                                    if (state is AddCartLoading) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return Text(widget.title);
                                  },
                                ),
                          false),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            }))
      ],
    );
  }
}
