import 'package:fixed_bids/controllers/notifications_controller.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/other/notifications.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsController>(
      builder: (__, value, _) {
        return CupertinoButton(
          onPressed: () {
            context.read<NotificationsController>().notificationCount = 0;
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
              color: value.notificationCount > 0
                  ? HexColor('D7E4F6')
                  : Color(0x0ffF1F1F1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: SizedBox(
                width: 21,
                height: 27,
                child: Stack(alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Notification.svg',
                       color: value.notificationCount > 0 ? kPrimaryColor : null,
                    ),
                    if(value.notificationCount > 0)
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        width: 12.05,
                        height: 12.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xffd7e4f6), width: 2, ),
                          color: Color(0xff1e71ec),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
