import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Color(0x0ffF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.all(7),
        child: Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
