import '../../delegate/search_delegate_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({super.key, this.isMain = true});

  final bool isMain;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        await showSearch(context: context, delegate: SearchDelegateProduct());
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: isMain
              ? Colors.transparent
              : Colors.grey.shade700.withOpacity(0.1),
          border: Border.all(color: isMain ? Colors.grey : Colors.transparent),
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
              'Search Product',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
