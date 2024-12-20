import '../../../bloc/product/product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item/start_display.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ShowBottomSheetBuyProduct) {
            showModalBottomSheet(
                context: context,
                builder: (context) => Column(
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
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(
                                        widget.product.image,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                  Expanded(
                                    child: Text(
                                      widget.product.title,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              BlocProvider(
                                create: (context) =>
                                    QuantityBloc(widget.product.price),
                                child: BlocBuilder<QuantityBloc, QuantityState>(
                                  builder: (context, state) {
                                    final quantity = state is QuantityUpdated
                                        ? state.quantity
                                        : 1;

                                    final totalPrice =
                                        widget.product.price * quantity;
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Quantity',
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<QuantityBloc>()
                                                        .add(
                                                            DecrementQuantity());
                                                  },
                                                  icon: const Icon(
                                                    CupertinoIcons.minus,
                                                    size: 15,
                                                  ),
                                                ),
                                                Text(
                                                  quantity.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<QuantityBloc>()
                                                        .add(
                                                            IncrementQuantity());
                                                  },
                                                  icon: const Icon(
                                                    CupertinoIcons.add,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total',
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            Text(
                                              'USD ${totalPrice.toString()}',
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Buy')),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    ));
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverAppBar(
                        leading: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.grey.shade400),
                                shape: WidgetStatePropertyAll(CircleBorder())),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        actions: [
                          Badge(
                            label: Text('7'),
                            child: IconButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.grey.shade400),
                                  shape:
                                      WidgetStatePropertyAll(CircleBorder())),
                              icon: Icon(
                                CupertinoIcons.shopping_cart,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          IconButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.grey.shade400),
                                shape: WidgetStatePropertyAll(CircleBorder())),
                            icon: Icon(
                              CupertinoIcons.chat_bubble_2,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.45,
                        pinned: true,
                        collapsedHeight: kToolbarHeight,
                        flexibleSpace: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            FlexibleSpaceBar(
                              background: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Hero(
                                  tag: widget.product.image,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    width: double.infinity,
                                    child: Image.network(
                                      widget.product.image,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const SizedBox(
                                          height: 150,
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
                                          height: 150,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverList.list(children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 20, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'USD ${widget.product.price}',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          StarDisplay(
                                            value: widget.product.rating.rate
                                                .toInt(),
                                          )
                                        ],
                                      ),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          LikeProductBloc(false),
                                      child: BlocBuilder<LikeProductBloc,
                                          LikeProductState>(
                                        builder: (context, state) {
                                          final isLiked =
                                              state is LikeProductUpdated
                                                  ? state.isLiked
                                                  : false;
                                          return Row(
                                            children: [
                                              Text(
                                                '${widget.product.rating.count} Sold',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<LikeProductBloc>()
                                                        .add(
                                                            LikedProductEvent());
                                                  },
                                                  icon: isLiked
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .heart_fill,
                                                          color: Colors.red,
                                                        )
                                                      : Icon(
                                                          CupertinoIcons.heart))
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      widget.product.title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      widget.product.description,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: double.infinity,
                              color: Colors.yellow.shade800,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.chat_bubble_text),
                                  Text('Chat Seller')
                                ],
                              ))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: double.infinity,
                              color: Colors.blue.shade800,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.shopping_cart),
                                  Text('Add To Cart')
                                ],
                              ))),
                      Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<ProductBloc>()
                                  .add(ShowBottomSheetBuyProductEvent());
                            },
                            child: Container(
                                height: double.infinity,
                                color: Colors.green.shade800,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Buy USD ${widget.product.price}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                )),
                          )),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
