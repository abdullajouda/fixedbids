import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIconButton extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final String svg;
  final VoidCallback onPressed;
  final bool isRounded;

  const MyIconButton(
      {Key key, this.color, this.iconColor, this.svg, this.onPressed, this.isRounded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color:color?? Color(0x0ffF1F1F1),
          borderRadius:isRounded?BorderRadius.all(Radius.elliptical(9999, 9999)): BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            svg,
            color: iconColor??Colors.black,
          ),
        ),
      ),
    );
  }
}
