import 'package:flutter/material.dart';

import '../constants.dart';

class Button extends StatelessWidget {
  final String title;

  const Button({Key key,@required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
            width: Data.size.width,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }
}
