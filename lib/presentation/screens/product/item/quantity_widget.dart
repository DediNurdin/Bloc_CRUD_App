import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    required this.txtQauntity,
    required this.onPressIncrement,
    required this.onPressDecrement,
    this.colorTxt,
    this.isCart = false,
  });

  final String txtQauntity;
  final Function() onPressIncrement;
  final Function() onPressDecrement;
  final Color? colorTxt;
  final bool isCart;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(widget.isCart ? 20 : 3),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: widget.onPressDecrement,
              icon: widget.isCart
                  ? widget.txtQauntity == '1'
                      ? Icon(
                          CupertinoIcons.trash,
                          size: 15,
                        )
                      : Icon(
                          CupertinoIcons.minus,
                          size: 15,
                        )
                  : Icon(
                      CupertinoIcons.minus,
                      size: 15,
                    ),
            ),
          ),
          Container(
            width: 30,
            height: 25,
            decoration: widget.isCart
                ? null
                : BoxDecoration(
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
