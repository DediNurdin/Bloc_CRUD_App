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
        width: 130,
        height: 130,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 50,
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.green,
                        ),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                            strokeWidth: 1.5,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
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
