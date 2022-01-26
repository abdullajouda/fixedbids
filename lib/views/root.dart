import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/nav_screens/chat_screen.dart';
import 'package:fixed_bids/widgets/notification_button.dart';
import 'package:fixed_bids/widgets/onExit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'nav_screens/contractor/contractor_home_screen.dart';
import 'nav_screens/contractor/contractor_profile_screen.dart';
import 'nav_screens/customer/home_screen.dart';
import 'nav_screens/customer/job_history_screen.dart';
import 'nav_screens/customer/profile_screen.dart';
import 'other/customer/choose_category.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
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
  List<Widget> _appBarList = [
    null,
    AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: Color(0x0ffF8F8F8),
      leading: Center(
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Color(0x0ffF1F1F1),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: NetworkImage(
                  Data.currentUser.imageProfile,
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        'Job history',
        style: Constants.applyStyle(size: 18, fontWeight: FontWeight.w600),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Center(
            child: NotificationButton(),
          ),
        )
      ],
    ),
    AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: Color(0x0ffF8F8F8),
      leading: Center(
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Color(0x0ffF1F1F1),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: NetworkImage(
                  Data.currentUser.imageProfile,
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        'Messages',
        style: Constants.applyStyle(size: 18, fontWeight: FontWeight.w600),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Center(child: NotificationButton()),
        )
      ],
    ),
    null
  ];

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    if (Data.currentUser.type == '2') {
      _bodyList = [
        ContractorHomeScreen(),
        JobHistoryScreen(),
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
                )
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
        appBar: _appBarList[_bottomNavIndex],
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
