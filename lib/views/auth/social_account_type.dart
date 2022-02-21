import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:fixed_bids/views/auth/sign_up_customer.dart';
import 'package:fixed_bids/views/auth/sign_up_provider.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:fixed_bids/widgets/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAccountType extends StatefulWidget {
  final String socialType;

  const SocialAccountType({Key key, this.socialType}) : super(key: key);

  @override
  _SocialAccountTypeState createState() => _SocialAccountTypeState();
}

class _SocialAccountTypeState extends State<SocialAccountType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                  padding: const EdgeInsets.all(22.0), child: MyBackButton()),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Choose account type'.tr(),
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
                      'What type of service you want?'.tr(),
                      style: TextStyle(
                        fontSize: 17,
                        color: kTextLightColor,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: Data.size.height * .1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                LoginResponse response;
                                if (widget.socialType == 'google') {
                                  GoogleSignIn _googleSignIn = GoogleSignIn(
                                    scopes: [
                                      'email',
                                    ],
                                  );
                                  if (await _googleSignIn.isSignedIn())
                                    await _googleSignIn.signOut();
                                  var account = await _googleSignIn.signIn();
                                  var token = await account.authentication;
                                  response = await GlobalController()
                                      .socialCreateNewAccount(
                                      token: token.accessToken,
                                      socialType: widget.socialType,
                                      type: 1); //// 1=user 2= worker
                                }
                                else if(widget.socialType == 'facebook') {
                                  final fb = FacebookLogin();
                                  final res = await fb.logIn(permissions: [
                                    FacebookPermission.publicProfile,
                                    FacebookPermission.email,
                                  ]);
                                  if (res.status ==
                                      FacebookLoginStatus.success) {
                                    response = await GlobalController()
                                        .socialCreateNewAccount(
                                        token: res.accessToken.token,
                                        socialType: widget.socialType,
                                        type: 1); //// 1=user 2= worker
                                  }
                                }

                                if (response.status) {
                                  Data.sharedPreferencesController
                                      .setIsLogin(true);
                                  Data.sharedPreferencesController
                                      .setUserData(response.user);
                                  Data.currentUser = response.user;
                                  Data.navigator.navigator
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => RootPage(),
                                  ));
                                } else {
                                  BotToast.showText(text: response.message);
                                }
                              },
                              child: Container(
                                height: 300,
                                width: Data.size.width * .4,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 22, horizontal: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'I want to'.tr(),
                                      style: Constants.applyStyle(
                                          color: Colors.white,
                                          size: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Hire a pro'.tr(),
                                      style: Constants.applyStyle(
                                          color: Colors.white,
                                          size: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Get a professional and talented service provider!'
                                          .tr(),
                                      style: Constants.applyStyle(
                                          color: Colors.white,
                                          size: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Container(
                                        height: 33,
                                        width: 33,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(9999, 9999)),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0x0ff1F71ED),
                                              Color(0x0ff649AEC),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Expanded(
                            child: Transform.translate(
                              offset: Offset(0, 30),
                              child: CupertinoButton(
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  LoginResponse response;
                                  if (widget.socialType == 'google') {
                                    GoogleSignIn _googleSignIn = GoogleSignIn(
                                      scopes: [
                                        'email',
                                      ],
                                    );
                                    if (await _googleSignIn.isSignedIn())
                                      await _googleSignIn.signOut();
                                    var account = await _googleSignIn.signIn();
                                    var token = await account.authentication;
                                    response = await GlobalController()
                                        .socialCreateNewAccount(
                                            token: token.accessToken,
                                            socialType: widget.socialType,
                                            type: 2); //// 1=user 2= worker
                                  }
                                  else if(widget.socialType == 'facebook') {
                                    final fb = FacebookLogin();
                                    final res = await fb.logIn(permissions: [
                                      FacebookPermission.publicProfile,
                                      FacebookPermission.email,
                                    ]);
                                    if (res.status ==
                                        FacebookLoginStatus.success) {
                                      response = await GlobalController()
                                          .socialCreateNewAccount(
                                              token: res.accessToken.token,
                                              socialType: widget.socialType,
                                              type: 2); //// 1=user 2= worker
                                    }
                                  }

                                  if (response.status) {
                                    Data.sharedPreferencesController
                                        .setIsLogin(true);
                                    Data.sharedPreferencesController
                                        .setUserData(response.user);
                                    Data.currentUser = response.user;
                                    Data.navigator.navigator
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => RootPage(),
                                    ));
                                  } else {
                                    BotToast.showText(text: response.message);
                                  }
                                },
                                child: Container(
                                  height: 300,
                                  width: Data.size.width * .4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/Rectangle.svg',
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 22, horizontal: 17),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'I want to'.tr(),
                                              style: Constants.applyStyle(
                                                  color: Color(0x0ff474747),
                                                  size: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              'Find a job'.tr(),
                                              style: Constants.applyStyle(
                                                  color: Color(0x0ff474747),
                                                  size: 22,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'Meet new customers and get a good job with superb earning!'
                                                  .tr(),
                                              style: Constants.applyStyle(
                                                  color: Color(0x0ff474747),
                                                  size: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Spacer(),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              child: Container(
                                                height: 33,
                                                width: 33,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.elliptical(
                                                                9999, 9999)),
                                                    color: Color(0x0ffECECEC)),
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Color(0x0ff958D8D),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
