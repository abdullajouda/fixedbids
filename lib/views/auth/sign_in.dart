import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController, passwordController;
  FocusNode emailNode, passwordNode;
  bool obscure = true;

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
      body: Column(
        children: [
          SvgPicture.asset('assets/images/logo_lines.svg'),
          Text(
            'Welcome back',
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
            'Sign in to your account',
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
                    label: 'Email address',
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
                    label: 'Password',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
