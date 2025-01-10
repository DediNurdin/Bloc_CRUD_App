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
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
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
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Container(
                  color: Colors.grey,
                  width: double.infinity,
                  child: Padding(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
