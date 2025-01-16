import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../bottom_navigation/main_menu.dart';
import '../cart/cart_page.dart';
import '../delegate/search_delegate_product.dart';
import 'item/buy_add_cart_dialog_widget.dart';
import 'item/product_item_widget.dart';
import 'item/review_widget.dart';

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
  late ScrollController scrollController;
  BuildContext? tabContext;

  bool showTabBar = false;
  bool isReadMore = false;

  final List<GlobalKey> tabType = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(animateToTab);
    super.initState();
  }

  void animateToTab() {
    late RenderBox box;

    for (var i = 0; i < tabType.length; i++) {
      if (tabType[i].currentContext != null) {
        box = tabType[i].currentContext!.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);

        if (scrollController.offset >= position.dy) {
          DefaultTabController.of(tabContext!).animateTo(
            i,
            duration: const Duration(milliseconds: 100),
          );
        }
      }
    }
  }

  void scrollToIndex(int index) async {
    scrollController.removeListener(animateToTab);
    final categories = tabType[index].currentContext!;
    await Scrollable.ensureVisible(
      categories,
      duration: const Duration(milliseconds: 600),
    );
    scrollController.addListener(animateToTab);
  }

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
      child: DefaultTabController(
        length: 3,
        child: Builder(builder: (context) {
          tabContext = context;
          return Scaffold(
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
          );
        }),
      ),
    );
  }

  Widget main() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels > 200 && !showTabBar) {
          setState(() {
            showTabBar = true;
          });
        } else if (scrollNotification.metrics.pixels <= 200 && showTabBar) {
          setState(() {
            showTabBar = false;
          });
        }
        return true;
      },
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  scrolledUnderElevation: 0,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(showTabBar ? 48.0 : 0.0),
                    child: AnimatedOpacity(
                      curve: Curves.easeIn,
                      opacity: showTabBar ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: showTabBar
                          ? TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                              onTap: (int index) => scrollToIndex(index),
                              tabs: [
                                Tab(
                                  text: 'Detail',
                                ),
                                Tab(
                                  text: 'Review',
                                ),
                                Tab(
                                  text: 'Recomendation',
                                )
                              ],
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () async {
                        await showSearch(
                            context: context,
                            delegate: SearchDelegateProduct(initQuery: ''));
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(CupertinoIcons.search)),
                    ),
                    Icon(CupertinoIcons.arrowshape_turn_up_right),
                    InkWell(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                      child: AddToCartIcon(
                        key: cartKey,
                        icon: Icon(
                          CupertinoIcons.shopping_cart,
                        ),
                        badgeOptions: const BadgeOptions(
                          active: true,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    InkWell(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
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
                SliverList.list(children: [
                  SizedBox(
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
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'USD ${widget.product.price}',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => LikeProductBloc(false),
                                child: BlocBuilder<LikeProductBloc,
                                    LikeProductState>(
                                  builder: (context, state) {
                                    final isLiked = state is LikeProductUpdated
                                        ? state.isLiked
                                        : false;
                                    return InkWell(
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
                                                size: 20,
                                              )
                                            : Icon(
                                                CupertinoIcons.heart,
                                                size: 20,
                                              ));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.amber,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${widget.product.rating.rate}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                ),
                                Icon(
                                  CupertinoIcons.camera,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '45',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                ),
                                Icon(
                                  CupertinoIcons.tray,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${widget.product.rating.count} ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Sold',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  detail(0),
                  review(1),
                  recomedation(2)
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
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
            ),
          )
        ],
      ),
    );
  }

  Widget review(int index) {
    return CupertinoFormSection(key: tabType[index], children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Review',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ReviewWidget()
          ],
        ),
      )
    ]);
  }

  Widget detail(int index) {
    return CupertinoFormSection(key: tabType[index], children: [
      Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Detail',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Description Product',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isReadMore = !isReadMore;
                  });
                },
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: isReadMore ? 100 : 3,
                  ),
                ),
              ),
            ],
          )),
    ]);
  }

  Widget recomedation(int index) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          CupertinoFormSection(key: tabType[index], children: [
            SizedBox(
              height: kToolbarHeight,
              child: Row(
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
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
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
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No Data'),
                  );
                },
              ),
            ),
          ]),
        ]);
  }
}
