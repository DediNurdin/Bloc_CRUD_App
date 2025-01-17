import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTransactionWidget extends StatelessWidget {
  const SearchTransactionWidget({
    super.key,
    this.query = '',
  });

  final String query;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (query == '') {
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
          color: Colors.transparent,
          border: Border.all(color: Colors.grey.shade700),
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
              query != '' ? query : 'Search Transaction',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
