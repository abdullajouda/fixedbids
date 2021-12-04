import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/other/notifications.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'notification_button.dart';

Widget buildAppBar({String title = '', Color color, List<Widget> actions}) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 80,
    title: Text(
      '$title',
      style: Constants.applyStyle(
        fontWeight: FontWeight.w600,
        size: 18,
        color: kAppbarTitleColor,
      ),
    ),
    centerTitle: true,
    backgroundColor: color ?? Color(0x0ffF8F8F8),
    leadingWidth: 90,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Center(child: MyBackButton()),
    ),
    actions: actions != null
        ? actions
        : [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Center(
                child: NotificationButton(),
              ),
            )
          ],
  );
}
