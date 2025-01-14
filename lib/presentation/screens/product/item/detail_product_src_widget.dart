import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class DetailProductSrcWidget extends StatefulWidget {
  const DetailProductSrcWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<DetailProductSrcWidget> createState() => _DetailProductSrcWidgetState();
}

class _DetailProductSrcWidgetState extends State<DetailProductSrcWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              height: 550,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.product.image,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 100,
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
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
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
      ],
    );
  }
}
