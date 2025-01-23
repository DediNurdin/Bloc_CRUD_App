import '../../../../utils/colors_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/cart/cart_bloc.dart';
import '../../../../bloc/product/product_bloc.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/utils.dart';
import '../product_detail_page.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget(
      {super.key, required this.product, this.isCart = false});
  final Product product;
  final bool isCart;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailPage(
            product: widget.product,
          );
        }));
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                key: widgetKey,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Utils.imageNetwork(
                        context, widget.product.image, double.infinity)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.product.title,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'USD ${widget.product.price}',
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.amber,
                        size: 10,
                      ),
                      Text(
                        '${widget.product.rating.rate} • ${widget.product.rating.count} sold',
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.category.capitalize(),
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.more_horiz,
                            size: 18,
                          )
                        ],
                      ))
                    ],
                  ),
                  widget.isCart
                      ? SizedBox(
                          width: double.infinity,
                          child: BlocProvider(
                            create: (context) => ProductDetailBloc(),
                            child: BlocConsumer<ProductDetailBloc,
                                ProductDetailState>(
                              listener: (context, state) {
                                if (state is AddCartSuccess) {
                                  Utils.showToast(state.message, false);
                                  context.read<CartBloc>().add(GetCartEvent());
                                }
                              },
                              builder: (context, state) {
                                return Utils.buttonWigget(() {
                                  context.read<ProductDetailBloc>().add(
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
                                }, BlocBuilder<ProductDetailBloc,
                                    ProductDetailState>(
                                  builder: (context, state) {
                                    if (state is AddCartLoading) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: colorDefaultGreen,
                                        ),
                                        Text(
                                          'Add To Cart',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    );
                                  },
                                ), true);
                              },
                            ),
                          ))
                      : SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
