import '../../../bloc/product/product_bloc.dart';
import 'item/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({super.key});

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category Products")),
      body: BlocBuilder<ProductCategoriesBloc, ProductCategoriesState>(
        builder: (context, state) {
          if (state is ProductCategoriesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductCategoriesSuccess) {
            context.read<ProductByCategoriesBloc>().add(
                GetProductByCategoriesEvent(category: state.categories[0]));
            return DefaultTabController(
              length: state.categories.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs: state.categories
                        .map((category) => Tab(text: category))
                        .toList(),
                    onTap: (index) {
                      final selectedCategory = state.categories[index];
                      context.read<ProductByCategoriesBloc>().add(
                          GetProductByCategoriesEvent(
                              category: selectedCategory));
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<ProductByCategoriesBloc,
                        ProductByCategoriesState>(
                      builder: (context, state) {
                        if (state is ProductByCategoriesLoading) {
                          return Center(
                              child: const CircularProgressIndicator());
                        }
                        if (state is ProductByCategoriesSuccess) {
                          return GridView.builder(
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
                ],
              ),
            );
          }
          return Center(child: Text("No categories available"));
        },
      ),
    );
  }
}
