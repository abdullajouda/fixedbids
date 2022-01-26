import 'package:easy_localization/easy_localization.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/views/auth/sign_in.dart';
import 'package:fixed_bids/views/other/terms.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../root.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
          title: 'Settings'.tr(),
          color: Colors.white,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            _buildSettingsBox(
              title: 'Terms',
              titleColor: Colors.black,
              svg: 'assets/icons/list.svg',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Terms(),
                    ));
              },
            ),
            _buildSettingsBox(
              title: 'Log out',
              titleColor: HexColor('FF0000'),
              svg: 'assets/icons/logout.svg',
              onTap: () {
                GlobalController().logout();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
            ),
          ],
        ));
  }

  _buildSettingsBox(
      {VoidCallback onTap, String title, String svg, Color titleColor}) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 22).add(EdgeInsets.only(bottom: 15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SvgPicture.asset(
                  svg,
                  color: titleColor,
                ),
                // MyIconButton(
                //   onPressed: () {
                //
                //   },
                //   svg: ,
                //   iconColor: HexColor('FF0000'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
