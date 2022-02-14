import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

class NoDataFound extends StatefulWidget {
  const NoDataFound({Key key}) : super(key: key);

  @override
  _NoDataFoundState createState() => _NoDataFoundState();
}

class _NoDataFoundState extends State<NoDataFound>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Data.size.width * .3,
            width: Data.size.width * .3,
            child: Lottie.asset('assets/no_data.json', controller: _controller,
                onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            }, repeat: false),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Nothing to show here.'.tr(),
            style: Constants.applyStyle(
                fontWeight: FontWeight.w700, color: kPrimaryColor, size: 18),
          )
        ],
      ),
    );
  }
}
