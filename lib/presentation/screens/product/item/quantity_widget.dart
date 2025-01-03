import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    required this.txtQauntity,
    required this.onPressIncrement,
    required this.onPressDecrement,
    this.colorTxt,
  });

  final String txtQauntity;
  final Function() onPressIncrement;
  final Function() onPressDecrement;
  final Color? colorTxt;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: widget.onPressDecrement,
              icon: const Icon(
                CupertinoIcons.minus,
                size: 15,
              ),
            ),
          ),
          Container(
            width: 30,
            height: 25,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey))),
            child: Center(
              child: Text(
                widget.txtQauntity,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: widget.colorTxt),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            width: 25,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: widget.onPressIncrement,
              icon: const Icon(
                CupertinoIcons.add,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
