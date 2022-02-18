import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:fixed_bids/views/auth/forgot_password.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/check_box.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../root.dart';
import 'account_type.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController, passwordController;
  FocusNode emailNode, passwordNode;
  bool obscure = true;
  bool remember = false;
  bool loading = false;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Data.size.height * .06,
              ),
              SvgPicture.asset('assets/images/logo_blue.svg'),
              SizedBox(
                height: Data.size.height * .06,
              ),
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
                key: _formKey,
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                      },
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Forgot password?'.tr(),
                        style: Constants.applyStyle(
                            size: 14, color: kPrimaryColor),
                      ),
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
                  loading:  loading,
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      LoginResponse userResponse = await GlobalController()
                          .signIn(
                          email: emailController.text,
                          password: passwordController.text);
                      if (userResponse.status && userResponse.code == 200) {
                        if(remember){
                          Data.sharedPreferencesController.setIsLogin(true);
                        }
                        Data.sharedPreferencesController
                            .setUserData(userResponse.user);
                        Data.currentUser = userResponse.user;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RootPage(),
                            ));
                      } else if (userResponse.code == 201) {
                        BotToast.showText(text: userResponse.message);
                      } else {
                        BotToast.showText(text: userResponse.message);
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Or, login with'.tr(),
                style:
                    Constants.applyStyle(size: 14, color: Color(0x0ff655D64)),
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
                    text: 'Don’t have an account?'.tr(),
                    children: [
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up'.tr(),
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
                        builder: (context) => AccountType(),
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
    );
  }
}
