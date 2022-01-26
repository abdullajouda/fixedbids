import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OnExit extends StatefulWidget {
  final Widget child;

  OnExit({Key key, this.child}) : super(key: key);

  @override
  _OnExitState createState() => _OnExitState();
}

class _OnExitState extends State<OnExit> {
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      BotToast.showText(text: 'Press again to exit'.tr());

      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () => onWillPop(), child: widget.child);
  }
}
