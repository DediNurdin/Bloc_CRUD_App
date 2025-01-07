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
        height: 40,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: isMain
              ? Colors.transparent
              : Colors.grey.shade700.withOpacity(0.1),
          border: Border.all(
              color: isMain
                  ? query != ''
                      ? Colors.green
                      : Colors.grey
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              size: 17,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              query != '' ? query : 'Search Product',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
