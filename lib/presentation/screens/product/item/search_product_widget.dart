import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../delegate/search_delegate_product.dart';

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({super.key, this.query = '', this.isMain = true});

  final String query;
  final bool isMain;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        if (query == '') {
          await showSearch(
              context: context,
              delegate: SearchDelegateProduct(initQuery: query));
        } else {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        }
      },
      child: Container(
        height: 37,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: isMain
              ? Colors.transparent
              : Colors.grey.shade700.withValues(alpha: 0.1),
          border: Border.all(
              color: isMain ? Colors.grey.shade700 : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              size: 15,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              query != '' ? query : 'Search Product',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
