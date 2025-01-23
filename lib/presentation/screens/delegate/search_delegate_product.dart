import '../../../utils/colors_app.dart';

import '../bottom_navigation/main_menu.dart';
import '../cart/cart_page.dart';
import '../product/item/product_item_widget.dart';
import '../../../utils/skeleton_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/theme_app.dart';
import '../../../utils/utils.dart';
import '../product/product_detail_page.dart';

class SearchDelegateProduct extends SearchDelegate<String> {
  final String initQuery;
  bool isViewingResults = false;

  SearchDelegateProduct({
    this.initQuery = '',
  });

  @override
  String get searchFieldLabel => 'Search Product';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Utils.isDarkMode(context)
        ? ThemeUtils.darkTheme(true)
        : ThemeUtils.lightTheme(true);
  }

  @override
  List<Widget>? buildActions(
    BuildContext context,
  ) {
    if (isViewingResults) {
      return [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(CupertinoIcons.cart)),
        ),
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
              padding: const EdgeInsets.only(right: 10),
              child: Icon(CupertinoIcons.line_horizontal_3)),
        ),
      ];
    } else {
      return [
        GestureDetector(
          onTap: () {},
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(CupertinoIcons.add_circled)),
        ),
      ];
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Utils.styleBuildLeadingAppBarSearch(() {
      close(context, query);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    isViewingResults = true;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: [
            Tab(
              text: 'Product',
            ),
            Tab(
              text: 'Seller',
            )
          ]),
          body: TabBarView(children: [
            BlocBuilder<ProductSearchBloc, ProductSearchState>(
              builder: (context, state) {
                if (state is ProductSearchLoading) {
                  return SkeletonWidget.gridSkeleton(context);
                }
                if (state is ProductInitial) {
                  context
                      .read<ProductSearchBloc>()
                      .add(GetProductSearchEvent());
                }
                if (state is ProductSearchSuccess) {
                  final List<Product> productSearch = state.products
                      .where((item) => item.title
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                  if (productSearch.isEmpty) {
                    return Center(child: Text('No Data'));
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          crossAxisCount: 2,
                          childAspectRatio: 0.79,
                        ),
                        itemBuilder: (context, index) {
                          return ProductItemWidget(
                              product: productSearch[index]);
                        },
                        itemCount: productSearch.length,
                      ),
                    );
                  }
                }
                if (state is ProductSearchFailure) {
                  return Center(child: Text('No Data'));
                }
                if (state is ProductSortFailure) {
                  return Center(child: Text('No Data'));
                }
                return Center(child: Text('No Data'));
              },
            ),
            Center(child: Text('No Data'))
          ])),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ProductLimitBloc, ProductLimitState>(
      builder: (context, state) {
        if (state is ProductLimitLoading) {
          return SizedBox(
            height: 130,
            child: SkeletonWidget.listSkeleton(context, true, 4),
          );
        }
        if (state is ProductLimitSuccess) {
          final List<Product> allProdSugest = state.productLimit
              .where((item) => item.title.toLowerCase().contains(initQuery != ''
                  ? initQuery.toLowerCase()
                  : query.toLowerCase()))
              .toList();
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allProdSugest.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailPage(product: allProdSugest[index]);
                      }));
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  CupertinoIcons.flame,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(allProdSugest[index].title)),
                              ],
                            ))),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(13),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.lightbulb,
                            color: Colors.grey, size: 15),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Search tips and tricks',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Text(
                      'Learn',
                      style: TextStyle(fontSize: 12, color: colorDefaultGreen),
                    )
                  ],
                ),
              )
            ],
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
    );
  }
}
