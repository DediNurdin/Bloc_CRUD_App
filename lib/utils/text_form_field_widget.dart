import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.textInputAction,
    required this.keyboardType,
    this.isPassword = false,
    this.isReadOnly = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isReadOnly;
  final void Function()? onTap;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.isReadOnly ? widget.onTap : null,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill this field';
        }
        return null;
      },
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscuringCharacter: '*',
      obscureText: isPasswordVisible,
      cursorColor: Colors.grey.shade600,
      cursorWidth: 0.5,
      readOnly: widget.isReadOnly,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: CupertinoColors.destructiveRed),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: CupertinoColors.destructiveRed),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: widget.labelText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility))
              : widget.isReadOnly
                  ? Icon(CupertinoIcons.chevron_down)
                  : null),
    );
  }
}
