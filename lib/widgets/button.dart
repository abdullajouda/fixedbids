import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Color fontColor;
  final bool hasBorder;
  final bool loading;

  const Button(
      {Key key,
      @required this.title,
      @required this.onPressed,
      this.color,
      this.fontColor,
      this.hasBorder = false,
      this.loading = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed == null ? kTextLightColor : color ?? kPrimaryColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
            width: Data.size.width,
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: hasBorder
                    ? Border.all(
                        color: HexColor('#E2E2E2'),
                        width: 1,
                      )
                    : null),
            child: Center(
              child:loading?ButtonLoad(): Text(
                '$title',
                style: TextStyle(
                  fontSize: 18,
                  color: fontColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }
}
