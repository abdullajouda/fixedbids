import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/ads_response.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';
import 'package:fixed_bids/views/auth/sign_in.dart';
import 'package:fixed_bids/views/auth/sign_up_customer.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants.dart';
import 'auth/account_type.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AdsResponse>(
        future: GlobalController().getAds(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Loading();
          }
          return Column(
            children: [
              Expanded(
                child: Container(
                  width: Data.size.width,
                  height: Data.size.height /2,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        _currentIndex = value;
                      });
                    },
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (context, index) => Image.network(
                      snapshot.data.items[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(alignment: Alignment.center,
                        children: List.generate(
                          snapshot.data.items.length,
                              (index) => AnimatedScale(
                            scale: index == _currentIndex ? 1 : 0,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(milliseconds: 300),
                            child: Padding(
                              padding: kPadding,
                              child: Column(
                                children: [
                                  Text(
                                    '${snapshot.data.items[index].title}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: kTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${snapshot.data.items[index].details}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: kTextMidColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Data.size.width * .1,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(snapshot.data.items.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.fastOutSlowIn,
                              height: 7,
                              width: _currentIndex == index ? 24 : 7,
                              decoration: BoxDecoration(
                                  color: _currentIndex == index ? kPrimaryColor : grayColor,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: Data.size.width * .05,
                      ),
                      Padding(
                        padding: kPadding,
                        child: Button(
                          title: 'Log into your account',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ));
                          },
                        ),
                      ),
                      CupertinoButton(
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 18,
                            color: kTextColor,
                            fontWeight: FontWeight.w600,
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
                    ],
                  ),
                ),
              )
            ],
          );

        },
      ),
    );
  }
}
