import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../utils/shimmer_widget.dart';
import 'item/product_item_widget.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("All Products")),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return ShimmerWidget.gridShimmer(context);
            }
            if (state is ProductSuccess) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    crossAxisCount: 2,
                    childAspectRatio: 0.79,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItemWidget(product: state.products[index]);
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
        ));
  }
}
