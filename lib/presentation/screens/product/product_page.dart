import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/user_model.dart';
import '../../../utils/shimmer_widget.dart';
import '../../../utils/utils.dart';
import '../cart/cart_page.dart';
import 'all_product_page.dart';
import 'item/product_item_limit_widget.dart';
import 'item/product_item_widget.dart';
import 'item/search_product_widget.dart';
import 'item/type_item_widget.dart';
import '../bottom_navigation/main_menu.dart';

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
  final PageController _pageController = PageController();
  Timer? _timer;
  UserModel? authData;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      int nextPage = _pageController.page!.toInt() + 1;
      if (nextPage >= imgCarousel.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: SearchProductWidget(),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(CupertinoIcons.chat_bubble_2)),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(CupertinoIcons.bell)),
            InkWell(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(CupertinoIcons.shopping_cart))),
            InkWell(
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
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(CupertinoIcons.line_horizontal_3)),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.list(children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SizedBox(
                    height: 170,
                    child: PageView.builder(
                      controller: _pageController,
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
                        controller: _pageController,
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return ShimmerWidget.chipShimmer(context);
                  } else if (state is AuthSuccess) {
                    final auth = state.auth;
                    authData = state.auth;
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
                                  avatar: Assets.icons.wallet.image(),
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
                                  avatar: Assets.icons.locationPin.image(),
                                  label: Text(
                                      'Send To ${auth.address.street.capitalize()}, ${auth.address.city.capitalize()}'))
                            ],
                          )),
                    );
                  }
                  return Container();
                },
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
                            icon: Assets.icons.bitcoin.path, title: 'Bitcoin'),
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
                            icon: Assets.icons.trolley.path, title: 'Car Fix'),
                        const SizedBox(
                          width: 15,
                        ),
                        ItemTypeWidget(
                            icon: Assets.icons.charity.path, title: 'Charity'),
                        const SizedBox(
                          width: 15,
                        ),
                        ItemTypeWidget(
                            icon: Assets.icons.gift.path, title: 'Voucher'),
                        const SizedBox(
                          width: 15,
                        ),
                        ItemTypeWidget(
                            icon: Assets.icons.wallet.path, title: 'Wallet'),
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
                      child: ShimmerWidget.listShimmer(context, true),
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

                  return Center(
                    child: Text('No Data'),
                  );
                },
              ),
              BlocBuilder<ProductCategoriesBloc, ProductCategoriesState>(
                builder: (context, state) {
                  if (state is ProductCategoriesLoading) {
                    return ShimmerWidget.chipShimmer(context);
                  }
                  if (state is ProductCategoriesSuccess) {
                    context.read<ProductByCategoriesBloc>().add(
                        GetProductByCategoriesEvent(
                            category: state.categories[0]));
                    return DefaultTabController(
                      length: state.categories.length,
                      child: TabBar(
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        tabs: state.categories
                            .map((category) =>
                                Tab(text: category.toString().capitalize()))
                            .toList(),
                        onTap: (index) {
                          final selectedCategory = state.categories[index];
                          context.read<ProductByCategoriesBloc>().add(
                              GetProductByCategoriesEvent(
                                  category: selectedCategory));
                        },
                      ),
                    );
                  }
                  return DefaultTabController(
                    length: 1,
                    child: TabBar(
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            text: 'Error . .',
                          )
                        ]),
                  );
                },
              ),
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
                      InkWell(
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AllProductPage()),
                          );
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      )
                    ],
                  )),
              BlocBuilder<ProductByCategoriesBloc, ProductByCategoriesState>(
                builder: (context, state) {
                  if (state is ProductByCategoriesLoading) {
                    return ShimmerWidget.gridShimmer(context);
                  }
                  if (state is ProductByCategoriesSuccess) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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
            ])
          ],
        ));
  }
}
