import 'package:fixed_bids/constants.dart';
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
