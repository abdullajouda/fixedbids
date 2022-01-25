import 'package:fixed_bids/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final String label;
  final Widget suffix;
  final bool obscure;
  final TextEditingController controller;
  final bool required;

  const CustomTextField(
      {Key key,
      this.focusNode,
      this.nextFocusNode,
      this.label,
      this.suffix,
      this.obscure = false,
      this.controller,
      this.required = true})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  void listenToFocus() {
    widget.focusNode.hasFocus;
    setState(() {});
  }

  @override
  void initState() {
    widget.focusNode.addListener(listenToFocus);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(listenToFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure,
      controller: widget.controller,
      validator: widget.required
          ? (value) => FieldValidator.validate(value, context)
          : null,
      decoration: inputDecoration(
        hint: widget.label,
        suffix: widget.suffix,
        focused: widget.focusNode.hasFocus || widget.controller?.text != '',
      ),
      focusNode: widget.focusNode,
      onFieldSubmitted: (value) {
        widget.focusNode.unfocus();
        FocusScope.of(context).requestFocus(widget.nextFocusNode);
        setState(() {});
      },
    );
  }
}
