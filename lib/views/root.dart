import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fixed_bids/controllers/notifications_controller.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/nav_screens/chat_screen.dart';
import 'package:fixed_bids/widgets/notification_button.dart';
import 'package:fixed_bids/widgets/onExit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'nav_screens/contractor/contractor_home_screen.dart';
import 'nav_screens/contractor/contractor_job_history_screen.dart';
import 'nav_screens/contractor/contractor_profile_screen.dart';
import 'nav_screens/customer/home_screen.dart';
import 'nav_screens/customer/job_history_screen.dart';
import 'nav_screens/customer/profile_screen.dart';
import 'other/contractor/near_by_jobs_map.dart';
import 'other/customer/choose_category.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  final int index;

  const RootPage({Key key, this.index}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  DatabaseReference _dbReference;
  StreamSubscription<DatabaseEvent> _usersSubscription;

  var _bottomNavIndex = 0;
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  final iconList = [
    'assets/icons/home_empty.svg',
    'assets/icons/list.svg',
    'assets/icons/Chat.svg',
    'assets/icons/User.svg',
  ];
  final selectedIconsList = [
    'assets/icons/home_full.svg',
    'assets/icons/list_full.svg',
    'assets/icons/Chat_full.svg',
    'assets/icons/User_full.svg',
  ];

  List<Widget> _bodyList = [];


  @override
  void initState() {
    _dbReference = FirebaseDatabase.instance.ref().child('Users');
    _dbReference.keepSynced(true);
    _dbReference.update({Data.currentUser.id.toString(): 'online'});
    _usersSubscription = _dbReference.onValue.listen(
      (event) {
        context.read<NotificationsController>().resetOnlineUsers();
        event.snapshot.children.forEach((element) {
          print(element.key);
          context
              .read<NotificationsController>()
              .updateOnlineUsers(key: element.key);
        });
      },
      onError: (Object o) {
        print('Error: ' + o.toString());
      },
      onDone: () {
        // dispose();
        print('Done Successfully !');
      },
    );

    if (widget.index != null) {
      _bottomNavIndex = widget.index;
    }
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1.2,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //TODO: set status to online here in firestore
      _dbReference.update({Data.currentUser.id.toString(): 'online'});
    } else {
      //TODO: set status to offline here in firestore
      _dbReference.child(Data.currentUser.id.toString()).remove();
    }
  }

  @override
  void dispose() {
     _animationController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    if (Data.currentUser.type == '2') {
      _bodyList = [
        ContractorHomeScreen(),
        ContractorJobHistoryScreen(),
        ChatScreen(),
        ContractorProfileScreen(),
      ];
    } else {
      _bodyList = [
        UserHomeScreen(),
        JobHistoryScreen(),
        ChatScreen(),
        ProfileScreen(),
      ];
    }

    return OnExit(
      child: Scaffold(
        backgroundColor: kBackGroundColor,
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: Data.currentUser.type == '2'
              ? FloatingActionButton(
                  elevation: 8,
                  backgroundColor: kPrimaryColor,
                  child: SvgPicture.asset('assets/icons/search2.svg'),
                  onPressed: () async {
                    LatLng initialPosition =
                        await Constants.getCurrentLocation(context: context);
                    if (initialPosition != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NearbyJobsMap(
                              initialPosition: initialPosition,
                            ),
                          )).then((value) {
                        _animationController.reset();
                        _animationController.forward();
                      });
                    }
                  })
              : FloatingActionButton(
                  elevation: 8,
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.add_rounded,
                    size: 32,
                    color: HexColor('#FFFFFF'),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseCategory(),
                        )).then((value) {
                      _animationController.reset();
                      _animationController.forward();
                    });
                  },
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final icon = isActive ? selectedIconsList[index] : iconList[index];
            return IconButton(
              onPressed: () {
                setState(() {
                  isActive = true;
                  _bottomNavIndex = index;
                });
              },
              icon: SizedBox(
                height: 23,
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                  ),
                ),
              ),
            );
          },
          backgroundColor: HexColor('#FFFFFF'),
          activeIndex: _bottomNavIndex,
          height: 70,
          splashColor: kPrimaryColor,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.center,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
         body: _bodyList[_bottomNavIndex],
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
