import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SomethingWentWrong extends StatelessWidget {
  final VoidCallback onPressed;

  const SomethingWentWrong({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SomeThing Went Wrong.'.tr(),
            style: Constants.applyStyle(
                fontWeight: FontWeight.w700, color: kPrimaryColor, size: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Button(
              title: 'Try Again'.tr(),
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}
