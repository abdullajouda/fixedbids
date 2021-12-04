import 'package:fixed_bids/views/other/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(),
            ));
      },
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Color(0x0ffF1F1F1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child:
            SvgPicture.asset('assets/icons/Notification.svg')),
      ),
    );
  }
}
