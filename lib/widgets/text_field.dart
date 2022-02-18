import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final String label;
  final Widget suffix;
  final Widget prefix;
  final bool obscure;
  final TextEditingController controller;
  final bool required;
  final bool isEmail;
  final bool readOnly;
  final int maxLines;
  final VoidCallback onPressed;
  final TextInputType inputType;

  const CustomTextField(
      {Key key,
      this.focusNode,
      this.nextFocusNode,
      this.label,
      this.suffix,
      this.prefix,
      this.obscure = false,
      this.readOnly = false,
      this.controller,
      this.onPressed,
      this.required = true,
      this.maxLines,
      this.inputType,
      this.isEmail = false})
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
    if (widget.focusNode != null) widget.focusNode.addListener(listenToFocus);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode != null)
      widget.focusNode.removeListener(listenToFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure,
      controller: widget.controller,
      keyboardType: widget.inputType,
      validator: widget.required
          ? (value) => widget.isEmail
              ? EmailValidator.validate(value, context)
              : FieldValidator.validate(value, context)
          : null,
      maxLines: widget.maxLines ?? 1,
      readOnly: widget.readOnly,
      onTap: widget.onPressed,
      decoration: inputDecoration(
        hint: widget.label,
        suffix: widget.suffix,
        prefix: widget.prefix,
        focused: (widget.focusNode != null && widget.focusNode.hasFocus) ||
            widget.controller?.text != '',
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
