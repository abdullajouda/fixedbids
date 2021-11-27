import 'package:fixed_bids/views/auth/sign_up_customer.dart';
import 'package:fixed_bids/views/auth/sign_up_provider.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:fixed_bids/widgets/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:fixed_bids/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountType extends StatefulWidget {
  const AccountType({Key key}) : super(key: key);

  @override
  _AccountTypeState createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
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
                padding: const EdgeInsets.all(22.0),
                child: MyBackButton()
              ),
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpCustomer(),
                                    ));
                              },
                              child: Container(
                                height: Data.size.height * .35,
                                width: Data.size.height * .2,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 22, horizontal: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'I want to',
                                      style: Constants.applyStyle(
                                          color: Colors.white,
                                          size: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Hire a pro',
                                      style: Constants.applyStyle(
                                          color: Colors.white,
                                          size: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Get a professional and talented service provider!',
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
                          Transform.translate(
                            offset: Offset(0, 30),
                            child: Expanded(
                              child: CupertinoButton(
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpProvider(),
                                      ));
                                },
                                child: Container(
                                  height: Data.size.height * .35,
                                  width: Data.size.height * .2,
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
                                              'I want to',
                                              style: Constants.applyStyle(
                                                  color: Color(0x0ff474747),
                                                  size: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              'Find a job',
                                              style: Constants.applyStyle(
                                                  color: Color(0x0ff474747),
                                                  size: 22,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'Meet new customers and get a good job with superb earning!',
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
                    SizedBox(
                      height: 100,
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
                        Navigator.pop(context);
                      },
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
