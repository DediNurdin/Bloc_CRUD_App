import '../cart/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import 'item/item_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          title: CupertinoSearchTextField(
            controller: _searchController,
            placeholder: 'Search Product',
            onSubmitted: (value) {},
          ),
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
        body: Column(
          children: [
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
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              right: 10, left: index == 0 ? 16 : 0),
                          child: Chip(
                            avatar: Icon(CupertinoIcons.bag_fill),
                            label: Text(state.categories[index]),
                          ),
                        );
                      },
                      itemCount: state.categories.length,
                    ),
                  );
                }

                return const Center(
                  child: Text('No Data'),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductSuccess) {
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<ProductBloc>().add(GetProductEvent());
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            crossAxisCount: 2,
                            childAspectRatio: 0.70,
                          ),
                          itemBuilder: (context, index) {
                            return ItemWidget(product: state.products[index]);
                          },
                          itemCount: state.products.length,
                        ),
                      ),
                    );
                  }

                  return const Center(
                    child: Text('No Data'),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
