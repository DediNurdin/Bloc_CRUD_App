import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import 'all_product_page.dart';
import 'item/product_item_limit_widget.dart';
import 'item/product_item_widget.dart';
import 'item/type_item_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

List<String> imgCarousel = [
  (Assets.images.banner1.path),
  (Assets.images.banner2.path),
  (Assets.images.banner3.path),
];

class _ProductPageState extends State<ProductPage> {
  final PageController carouselController = PageController();
  Timer? timerCarousel;

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  void startAutoScroll() {
    timerCarousel = Timer.periodic(Duration(seconds: 5), (timer) {
      int nextPage = carouselController.page!.toInt() + 1;
      if (nextPage >= imgCarousel.length) {
        nextPage = 0;
      }
      carouselController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timerCarousel?.cancel();
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductCategoriesBloc, ProductCategoriesState>(
        listener: (context, categoryState) {
          if (categoryState is ProductCategoriesError) {
            Utils.showToast(categoryState.message, true);
          }
        },
        builder: (context, categoryState) {
          return DefaultTabController(
            length: categoryState is ProductCategoriesSuccess
                ? categoryState.categories.length
                : 0,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            SizedBox(
                              height: 170,
                              child: PageView.builder(
                                controller: carouselController,
                                itemCount: imgCarousel.length,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    imgCarousel[index],
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Center(
                                child: SmoothPageIndicator(
                                  controller: carouselController,
                                  count: imgCarousel.length,
                                  effect: ExpandingDotsEffect(
                                    spacing: 2,
                                    dotHeight: 5,
                                    dotWidth: 10,
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        BlocProvider(
                          create: (context) => AuthBloc()..add(GetAuthEvent()),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return SkeletonWidget.chipSkeleton(context);
                              } else if (state is AuthSuccess) {
                                final auth = state.auth;
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Chip(
                                              avatar:
                                                  Assets.icons.wallet.image(),
                                              label: Text('USD 150.4892')),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Chip(
                                              avatar: Assets.icons.gift.image(),
                                              label: Text('Check Voucher')),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Chip(
                                              avatar: Assets.icons.locationPin
                                                  .image(),
                                              label: Text(
                                                  'Send To ${auth.address.street.capitalize()}, ${auth.address.city.capitalize()}'))
                                        ],
                                      )),
                                );
                              }
                              return SizedBox(
                                height: 70,
                                child: Center(
                                  child: Text(
                                    'Failed to load data',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.insurance.path,
                                      title: 'Insurance'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.bitcoin.path,
                                      title: 'Bitcoin'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.investment.path,
                                      title: 'Invesment'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.remoteControl.path,
                                      title: 'Games'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.trolley.path,
                                      title: 'Car Fix'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.charity.path,
                                      title: 'Charity'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.gift.path,
                                      title: 'Voucher'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ItemTypeWidget(
                                      icon: Assets.icons.wallet.path,
                                      title: 'Wallet'),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Most Popular',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        BlocBuilder<ProductLimitBloc, ProductLimitState>(
                          builder: (context, state) {
                            if (state is ProductLimitLoading) {
                              return SizedBox(
                                height: 130,
                                child: SkeletonWidget.listSkeleton(
                                    context, true, 4),
                              );
                            }
                            if (state is ProductLimitSuccess) {
                              return SizedBox(
                                height: 130,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 10 : 0,
                                          right: index == 6 ? 10 : 0),
                                      child: ProductItemLimitWidget(
                                          product: state.productLimit[index]),
                                    );
                                  },
                                  itemCount: state.productLimit.length,
                                ),
                              );
                            }
                            return SizedBox(
                              height: 70,
                              child: Center(
                                child: Text(
                                  'Failed to load data',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (categoryState is ProductCategoriesSuccess)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverTabBarDelegate(
                        TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          tabs: categoryState.categories
                              .map((category) =>
                                  Tab(text: category.toString().capitalize()))
                              .toList(),
                        ),
                      ),
                    ),
                ];
              },
              body: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'Best Products',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AllProductPage()),
                              );
                            },
                            child: Text(
                              'See All',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          )
                        ],
                      )),
                  if (categoryState is ProductCategoriesSuccess)
                    Expanded(
                      child: TabBarView(
                        children: categoryState.categories.map((category) {
                          return BlocProvider(
                            create: (context) => ProductByCategoriesBloc()
                              ..add(GetProductByCategoriesEvent(
                                  category: category)),
                            child: BlocBuilder<ProductByCategoriesBloc,
                                ProductByCategoriesState>(
                              builder: (context, productState) {
                                if (productState
                                    is ProductByCategoriesLoading) {
                                  return SkeletonWidget.gridSkeleton(context);
                                } else if (productState
                                    is ProductByCategoriesSuccess) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.79,
                                      ),
                                      itemBuilder: (context, index) {
                                        return ProductItemWidget(
                                            product: productState
                                                .productByCategories[index]);
                                      },
                                      itemCount: productState
                                          .productByCategories.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  if (categoryState is ProductByCategoriesError)
                    SliverToBoxAdapter(
                      child: Center(
                          child: Text("Failed to load categories",
                              style: TextStyle(fontSize: 12))),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Utils.isDarkMode(context)
          ? CupertinoColors.darkBackgroundGray
          : CupertinoColors.systemBackground,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
