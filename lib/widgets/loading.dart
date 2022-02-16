import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(
        height: Data.size.width * .3,
        width: Data.size.width * .3,
        child: Lottie.asset('assets/loading.json')));
  }
}


class ButtonLoad extends StatelessWidget {
  const ButtonLoad({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(
        height: 25,
        width: 25,
        child: Lottie.asset('assets/button_load.json')));
  }
}