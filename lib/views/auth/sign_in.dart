import 'dart:io';

import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/auth/sign_up.dart';
import 'package:fixed_bids/views/place_picker.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/check_box.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController, passwordController;
  FocusNode emailNode, passwordNode;
  bool obscure = true;
  bool remember = false;

  @override
  void initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    emailNode = new FocusNode();
    passwordNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset('assets/images/logo_lines.svg'),
            Text(
              'Welcome back'.tr(),
              style: TextStyle(
                fontSize: 24,
                color: kTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Sign in to your account'.tr(),
              style: TextStyle(
                fontSize: 17,
                color: kTextLightColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Data.size.height * .06,
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: kPadding,
                    child: CustomTextField(
                      controller: emailController,
                      focusNode: emailNode,
                      nextFocusNode: passwordNode,
                      label: 'Email address'.tr(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: kPadding,
                    child: CustomTextField(
                      controller: passwordController,
                      focusNode: passwordNode,
                      obscure: obscure,
                      nextFocusNode: null,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(obscure
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill),
                      ),
                      label: 'Password'.tr(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        remember = !remember;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomCheckBox(
                          value: remember,
                          onPressed: () {
                            setState(() {
                              remember = !remember;
                            });
                          },
                        ),
                        Text(
                          'Remember me'.tr(),
                          style: Constants.applyStyle(
                              size: 14, color: Color(0x0ff655D64)),
                        )
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'Forgot password?'.tr(),
                      style:
                          Constants.applyStyle(size: 14, color: kPrimaryColor),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kPadding,
              child: Button(
                title: 'Log in'.tr(),
                onPressed: () async {
                  LatLng initialPosition =
                      await Constants.getCurrentLocation(context: context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlacePickerScreen(
                          initialPosition: initialPosition,
                          onPlacePicked: (p0) {
                            Navigator.pop(context);
                          },
                        ),
                      ));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Or, login with'.tr(),
              style: Constants.applyStyle(size: 14, color: Color(0x0ff655D64)),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 54,
                  width: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0x0ffF3F3F3),
                  ),
                  child: CupertinoButton(
                    child: SvgPicture.asset('assets/images/google.svg'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 54,
                  width: 68,
                  decoration: BoxDecoration(
                    color: Color(0x0ffF3F3F3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CupertinoButton(
                    child: SvgPicture.asset('assets/images/fb.svg'),
                    onPressed: () {},
                  ),
                ),
                if (Platform.isIOS)
                  SizedBox(
                    width: 30,
                  ),
                if (Platform.isIOS)
                  Container(
                    height: 54,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Color(0x0ffF3F3F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CupertinoButton(
                      child: SvgPicture.asset('assets/images/apple.svg'),
                      onPressed: () {},
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            CupertinoButton(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: kTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                  text: 'Don’t have an account?',
                  children: [
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ));
              },
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
