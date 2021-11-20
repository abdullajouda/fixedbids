import 'package:fixed_bids/views/auth/sign_in.dart';
import 'package:fixed_bids/views/auth/sign_up.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;
  List _images = [
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
  ];

  List _titles = [
    ['Welcome back', 'We provide service and best quality...'],
    [
      'Clean your house',
      'Confused about your outfit? Don’t worry! Find the best outfit here'
    ],
    [
      'Clean your house',
      'Confused about your outfit? Don’t worry! Find the best outfit here'
    ],
    [
      'Clean your house',
      'Confused about your outfit? Don’t worry! Find the best outfit here'
    ],
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Data.size.width,
            height: Data.size.width * 1.222,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) => Image.network(
                _images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: Data.size.width * .1,
          ),
          Stack(alignment: Alignment.center,
            children: List.generate(
              _titles.length,
              (index) => AnimatedScale(
                scale: index == _currentIndex ? 1 : 0,
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300),
                child: Padding(
                  padding: kPadding,
                  child: Column(
                    children: [
                      Text(
                        '${_titles[index][0]}',
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
                        '${_titles[index][1]}',
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
            children: List.generate(_images.length, (index) {
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
            height: Data.size.width * .1,
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
                    builder: (context) => SignUp(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
