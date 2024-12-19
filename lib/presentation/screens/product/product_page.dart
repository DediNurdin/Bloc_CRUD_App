import '../../../bloc/product/product_bloc.dart';
import 'item/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Home',
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductSuccess) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(GetProductEvent());
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 7,
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
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
    );
  }
}
