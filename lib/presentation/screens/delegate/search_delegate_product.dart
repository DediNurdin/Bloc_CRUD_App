import '../bottom_navigation/main_menu.dart';
import '../cart/cart_page.dart';
import '../product/item/product_item_widget.dart';
import '../../../utils/skeleton_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/colors.dart';
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
                        return ProductItemWidget(product: productSearch[index]);
                      },
                      itemCount: productSearch.length,
                    ),
                  );
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
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        if (state is ProductSearchLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is ProductInitial) {
          context.read<ProductSearchBloc>().add(GetProductSearchEvent());
        }
        if (state is ProductSearchSuccess) {
          final List<Product> allProdSugest = state.products
              .where((item) => item.title.toLowerCase().contains(initQuery != ''
                  ? initQuery.toLowerCase()
                  : query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: allProdSugest.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailPage(product: allProdSugest[index]);
                  }));
                },
                child: Card(
                    margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(allProdSugest[index].title))),
              );
            },
          );
        }
        return Center(child: Text('No Data'));
      },
    );
  }
}
