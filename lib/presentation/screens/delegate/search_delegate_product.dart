import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/utils.dart';
import '../product/product_detail_page.dart';

class SearchDelegateProduct extends SearchDelegate<String> {
  final TextEditingController? provController;
  final TextEditingController? provIdController;

  SearchDelegateProduct({
    this.provController,
    this.provIdController,
  });

  @override
  String get searchFieldLabel => 'Search Product';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return Utils.styleBuildActionAppBarSearch(() {
      query = '';
    }, query != '' ? true : false);
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
          final List<Product> allProvResult = state.products
              .where((item) =>
                  item.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: allProvResult.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailPage(product: allProvResult[index]);
                  }));
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: 70,
                                width: 60,
                                child: Image.network(
                                  allProvResult[index].image,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Text(allProvResult[index].title))
                        ],
                      )),
                ),
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
          final List<Product> allProvSugest = state.products
              .where((item) =>
                  item.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: allProvSugest.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailPage(product: allProvSugest[index]);
                  }));
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: 70,
                                width: 60,
                                child: Image.network(
                                  allProvSugest[index].image,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Text(allProvSugest[index].title))
                        ],
                      )),
                ),
              );
            },
          );
        }
        return Center(child: Text('No Data'));
      },
    );
  }
}
