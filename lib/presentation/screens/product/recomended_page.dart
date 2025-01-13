import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../utils/shimmer_widget.dart';
import 'item/product_item_widget.dart';

class RecomendedPage extends StatelessWidget {
  const RecomendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection(children: [
      SizedBox(
        height: kToolbarHeight,
        child: Row(
          children: [
            Expanded(child: Divider()),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Recomended For You',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Divider()),
          ],
        ),
      ),
      BlocProvider(
        create: (context) => ProductBloc()..add(GetProductEvent()),
        child: BlocBuilder<ProductBloc, ProductState>(
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
        ),
      )
    ]);
  }
}
