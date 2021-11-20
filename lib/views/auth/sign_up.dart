import 'dart:io';

import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/check_box.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController,
      nameController,
      passwordController,
      retypePasswordController;
  FocusNode emailNode, passwordNode, retypePasswordNode, nameNode;
  bool obscure = true;
  bool obscureRetype = true;
  bool agree = false;

  @override
  void initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    nameController = new TextEditingController();
    retypePasswordController = new TextEditingController();
    emailNode = new FocusNode();
    passwordNode = new FocusNode();
    retypePasswordNode = new FocusNode();
    nameNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    retypePasswordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    retypePasswordNode.dispose();
    nameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SvgPicture.asset('assets/images/colored_lines_reverse.svg'),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Color(0x0ffF3F3F3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(7),
                          child:
                              Center(child: Icon(Icons.arrow_back_ios_rounded)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Create an account'.tr(),
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
                    'Discover your perfect service'.tr(),
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
                            nextFocusNode: nameNode,
                            label: 'Email address'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: kPadding,
                          child: CustomTextField(
                            controller: nameController,
                            focusNode: nameNode,
                            nextFocusNode: passwordNode,
                            label: 'Full Name'.tr(),
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
                            nextFocusNode: retypePasswordNode,
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: kPadding,
                          child: CustomTextField(
                            controller: retypePasswordController,
                            focusNode: retypePasswordNode,
                            obscure: obscureRetype,
                            nextFocusNode: null,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureRetype = !obscureRetype;
                                });
                              },
                              icon: Icon(obscureRetype
                                  ? CupertinoIcons.eye_fill
                                  : CupertinoIcons.eye_slash_fill),
                            ),
                            label: 'Retype Password'.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: kPadding,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            agree = !agree;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomCheckBox(
                              value: agree,
                              onPressed: () {
                                setState(() {
                                  agree = !agree;
                                });
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0x0ff655D64),
                                  fontWeight: FontWeight.w400,
                                ),
                                text: 'Agreed to the ',
                                children: [
                                  TextSpan(
                                    text: 'terms',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      print('object');
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: TextStyle(),
                                  ),
                                  TextSpan(
                                    text: 'conditions',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('object');
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: kPadding,
                    child: Button(
                      title: 'Sign up'.tr(),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Or, sign up with'.tr(),
                    style: Constants.applyStyle(
                        size: 14, color: Color(0x0ff655D64)),
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
                        text: 'I Already have an account?',
                        children: [
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
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
          ),
        ],
      ),
    );
  }
}
