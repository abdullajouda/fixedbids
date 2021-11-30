import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildAppBar({String title}) {
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
    backgroundColor: Color(0x0ffF8F8F8),
    leadingWidth: 90,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Center(child: MyBackButton()),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Center(
          child: CupertinoButton(
            onPressed: () {},
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
                  child: SvgPicture.asset('assets/icons/Notification.svg')),
            ),
          ),
        ),
      )
    ],
  );
}
