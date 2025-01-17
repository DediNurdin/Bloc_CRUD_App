import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';
import '../product_detail_page.dart';

class ProductItemLimitWidget extends StatelessWidget {
  const ProductItemLimitWidget({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailPage(
            product: product,
          );
        }));
      },
      child: SizedBox(
        width: 110,
        height: 120,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Utils.imageNetwork(
                          context, product.image, double.infinity)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                product.title,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
