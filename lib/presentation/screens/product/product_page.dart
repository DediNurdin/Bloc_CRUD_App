import '../../../gen/assets.gen.dart';
import 'product_category_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../cart/cart_page.dart';
import 'item/product_item_widget.dart';
import 'item/search_product_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: SearchProductWidget(),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              onPressed: () {},
            )
          ],
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverList.list(children: [
              SizedBox(
                height: 200,
                child: CarouselView(
                  shape: BeveledRectangleBorder(),
                  itemSnapping: false,
                  itemExtent: double.infinity,
                  reverse: true,
                  children: List.generate(
                    imgCarousel.length,
                    (index) => Image.asset(
                      imgCarousel[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              BlocBuilder<ProductCategoriesBloc, ProductCategoriesState>(
                builder: (context, state) {
                  if (state is ProductCategoriesLoading) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  }
                  if (state is ProductCategoriesSuccess) {
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: 10, left: index == 0 ? 16 : 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductCategoryPage()),
                                );
                              },
                              child: Chip(
                                avatar: Icon(CupertinoIcons.bag),
                                label: Text(
                                  state.categories[index],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No Data'),
                  );
                },
              ),
              Container(
                  margin: const EdgeInsets.only(left: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Best Products',
                    style: TextStyle(fontSize: 16),
                  )),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return SizedBox(
                      height: 200,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is ProductSuccess) {
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
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
                              product: state.products[index]);
                        },
                        itemCount: state.products.length,
                      ),
                    );
                  }

                  if (state is ProductFailure) {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
                  return Container();
                },
              )
            ])
          ],
        ));
  }
}
