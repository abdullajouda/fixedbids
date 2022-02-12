
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Conditions extends StatefulWidget {
  const Conditions({Key key}) : super(key: key);

  @override
  _ConditionsState createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: Data.settings.settings.pages[1].title,actions: []),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Html(data: Data.settings.settings.pages[1].description,)),
    );
  }
}
