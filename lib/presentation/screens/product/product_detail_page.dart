import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../cart/cart_page.dart';
import 'item/buy_add_cart_dialog_widget.dart';
import 'item/product_item_widget.dart';
import 'item/review_widget.dart';
import 'item/search_product_widget.dart';

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
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  bool showSearchBar = false;
  void addCartAnim(GlobalKey widgetKey, int quantity) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!.runCartAnimation((quantity).toString());
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
            listener: (context, state) {
          if (state is AddCartSuccess) {
            addCartAnim(state.key, state.quantity);
            if (!context.mounted) return;
            Navigator.of(context).pop();
          } else if (state is AddCartError) {
            Utils.showToast(state.error);
          }

          if (state is ShowBottomSheetBuyProduct) {
            showModalBottomSheet(
                context: context,
                builder: (context) => BuyAddCartDialogWidget(
                      product: widget.product,
                      title: 'Buy',
                    ));
          }

          if (state is ShowBottomSheetAddCartProduct) {
            showModalBottomSheet(
                context: context,
                builder: (context) => BuyAddCartDialogWidget(
                      product: widget.product,
                      title: 'Add To Cart',
                    ));
          }
        }, builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailSuccess) {
            return main();
          } else if (state is ProductDetailInitial) {
            context.read<ProductDetailBloc>().add(GetProductDetailEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddCartLoading) {
            return main();
          }
          return const Center(
            child: Text('No Data'),
          );
        }),
      ),
    );
  }

  Widget main() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels > 200 && !showSearchBar) {
          setState(() {
            showSearchBar = true;
          });
        } else if (scrollNotification.metrics.pixels <= 200 && showSearchBar) {
          setState(() {
            showSearchBar = false;
          });
        }
        return true;
      },
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  scrolledUnderElevation: 0,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                  leading: IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(showSearchBar
                            ? Colors.transparent
                            : Colors.grey.shade400),
                        shape: WidgetStatePropertyAll(CircleBorder())),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: showSearchBar ? Colors.green : Colors.black,
                    ),
                  ),
                  title: showSearchBar
                      ? SearchProductWidget(
                          isMain: false,
                        )
                      : null,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                showSearchBar
                                    ? Colors.transparent
                                    : Colors.grey.shade400),
                            shape: WidgetStatePropertyAll(CircleBorder())),
                        icon: AddToCartIcon(
                          key: cartKey,
                          icon: Icon(
                            CupertinoIcons.shopping_cart,
                            color: showSearchBar ? Colors.green : Colors.black,
                          ),
                          badgeOptions: const BadgeOptions(
                            active: true,
                            backgroundColor: Colors.red,
                          ),
                        )),
                    IconButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(showSearchBar
                              ? Colors.transparent
                              : Colors.grey.shade400),
                          shape: WidgetStatePropertyAll(CircleBorder())),
                      icon: Icon(
                        CupertinoIcons.chat_bubble_2,
                        color: showSearchBar ? Colors.green : Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                  expandedHeight: MediaQuery.of(context).size.height * 0.40,
                  pinned: true,
                  collapsedHeight: kToolbarHeight,
                  flexibleSpace: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      FlexibleSpaceBar(
                        background: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: double.infinity,
                            child: Image.network(
                              widget.product.image,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
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
                                      strokeWidth: 1.5,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                      )
                    ],
                  ),
                ),
                SliverList.list(children: [
                  Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'USD ${widget.product.price}',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                child: BlocProvider(
                                  create: (context) => LikeProductBloc(false),
                                  child: BlocBuilder<LikeProductBloc,
                                      LikeProductState>(
                                    builder: (context, state) {
                                      final isLiked =
                                          state is LikeProductUpdated
                                              ? state.isLiked
                                              : false;
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${widget.product.rating.count} Sold',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                context
                                                    .read<LikeProductBloc>()
                                                    .add(LikedProductEvent());
                                              },
                                              child: isLiked
                                                  ? Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color: Colors.red,
                                                      size: 15,
                                                    )
                                                  : Icon(
                                                      CupertinoIcons.heart,
                                                      size: 15,
                                                    ))
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.product.title,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                '${widget.product.rating.rate}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Product Ratings (2862)',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ReviewWidget(),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'You May Also Like',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  BlocProvider(
                    create: (context) => ProductByCategoriesBloc()
                      ..add(GetProductByCategoriesEvent(
                          category: widget.product.category)),
                    child: BlocBuilder<ProductByCategoriesBloc,
                        ProductByCategoriesState>(
                      builder: (context, state) {
                        if (state is ProductByCategoriesLoading) {
                          return SkeletonWidget.gridSkeleton(context);
                        }
                        if (state is ProductByCategoriesSuccess) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              crossAxisCount: 2,
                              childAspectRatio: 0.79,
                            ),
                            itemBuilder: (context, index) {
                              return ProductItemWidget(
                                  product: state.productByCategories[index]);
                            },
                            itemCount: state.productByCategories.length,
                          );
                        }
                        return const Center(
                          child: Text('No Data'),
                        );
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Icon(
                        CupertinoIcons.text_bubble,
                        color: Colors.grey,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 3,
                      child: Utils.buttonWigget(() {
                        context
                            .read<ProductDetailBloc>()
                            .add(ShowBottomSheetAddCartProductEvent());
                      }, Text('Add To Cart'), true)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 3,
                      child: Utils.buttonWigget(() {
                        context
                            .read<ProductDetailBloc>()
                            .add(ShowBottomSheetBuyProductEvent());
                      },
                          Text(
                            'Buy USD ${widget.product.price}',
                          ),
                          false)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
