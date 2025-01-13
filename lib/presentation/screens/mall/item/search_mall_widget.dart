import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../delegate/search_delegate_product.dart';

class SearchMallWidget extends StatelessWidget {
  const SearchMallWidget({
    super.key,
    this.query = '',
  });

  final String query;
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
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey.shade700),
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
              query != '' ? query : 'Search Mall',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
