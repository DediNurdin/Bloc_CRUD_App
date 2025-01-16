import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ItemTypeWidget extends StatefulWidget {
  const ItemTypeWidget({super.key, required this.icon, required this.title});

  final String icon;
  final String title;

  @override
  State<ItemTypeWidget> createState() => _ItemTypeWidgetState();
}

class _ItemTypeWidgetState extends State<ItemTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Utils.isDarkMode(context)
                  ? Colors.grey.shade900
                  : CupertinoColors.secondarySystemBackground),
          child: Image.asset(
            widget.icon,
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
