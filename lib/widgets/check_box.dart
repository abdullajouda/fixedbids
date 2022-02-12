import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final VoidCallback onPressed;
  const CustomCheckBox({Key key, this.value, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2.5,
              color: value ? kPrimaryColor : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: value
            ? Center(
            child: Icon(
              CupertinoIcons.checkmark_alt,
              color: kPrimaryColor,
              size: 15,
            ))
            : Container(),
      ),
    );
  }
}
