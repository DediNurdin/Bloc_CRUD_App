import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../product/product_detail_page.dart';
import '../product/search_product_page.dart';

class SearchDelegateProduct extends SearchDelegate<String> {
  final String initQuery;

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
    return Utils.styleBuildActionAppBarSearch(
      () {
        if (query != '') {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SearchProductPage(
                      query: query,
                    )),
          );
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Utils.styleBuildLeadingAppBarSearch(() {
      close(context, query);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductInitial) {
          context.read<ProductSearchBloc>().add(GetProductSearchEvent());
        }
        if (state is ProductSearchSuccess) {
          final List<Product> allProdResult = state.products
              .where((item) => item.title.toLowerCase().contains(initQuery != ''
                  ? initQuery.toLowerCase()
                  : query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: allProdResult.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailPage(product: allProdResult[index]);
                  }));
                },
                child: Card(
                    margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(allProdResult[index].title))),
              );
            },
          );
        }
        return Center(child: Text('No Data'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        if (state is ProductSearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
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
              return InkWell(
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
