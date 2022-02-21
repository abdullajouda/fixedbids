import 'package:fixed_bids/controllers/firebase_messaging_service.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/controllers/shared_preferences_controller.dart';
import 'package:fixed_bids/views/auth/sign_in.dart';
import 'package:fixed_bids/views/onboarding.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  landingPage() async {
    FirebaseMessagingService().getToken();
    Data.sharedPreferencesController =
        await SharedPreferencesController.instance;
    await Future.delayed(_controller.duration);
    await GlobalController().getSettings();
    if (Data.sharedPreferencesController.getIsLogin()) {
      Data.currentUser = Data.sharedPreferencesController.getUserData();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootPage(),
          ));
    } else {
      if (Data.sharedPreferencesController.getAppLaunchTimes() != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoardingScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ));
      }
    }
    FirebaseMessagingService().initialise();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    landingPage();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Data.size = size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x0ff1F71ED),
              Color(0x0ff649AEC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: size.width * .3,
              width: size.width * .3,
              child: Lottie.asset('assets/logo.json', controller: _controller,
                  onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              }, repeat: false),
            ),
            // SvgPicture.asset('assets/images/logo.svg'),
            Positioned(
                bottom: size.height * .1,
                child: SvgPicture.asset('assets/images/FixedBids.svg')),
          ],
        ),
      ),
    );
  }
}
