import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../utils/skeleton_widget.dart';
import 'item/product_item_widget.dart';

class RecomendedPage extends StatelessWidget {
  const RecomendedPage(
      {super.key, this.visibleTitle = true, this.isCart = false});

  final bool visibleTitle;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    return visibleTitle
        ? Utils.customColumn(
            context,
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Recomended For You',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  main()
                ]))
        : main();
  }

  Widget main() {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetAllProductEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return SkeletonWidget.gridSkeleton(context);
          }
          if (state is ProductSuccess) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  crossAxisCount: 2,
                  childAspectRatio: isCart ? 0.65 : 0.75,
                ),
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    product: state.products[index],
                    isCart: isCart,
                  );
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
    );
  }
}
