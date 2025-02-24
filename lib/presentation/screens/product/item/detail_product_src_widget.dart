import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';
import '../../../../utils/utils.dart';

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
                icon: Icon(CupertinoIcons.clear))
          ],
        ),
        Expanded(
          child: Center(
            child: SizedBox(
                height: 550,
                width: MediaQuery.of(context).size.width,
                child: Utils.imageNetwork(context, widget.product.image, 550)),
          ),
        ),
      ],
    );
  }
}
