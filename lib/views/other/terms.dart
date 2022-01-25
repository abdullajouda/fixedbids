
import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Terms extends StatefulWidget {
  const Terms({Key key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: Data.settings.settings.pages[2].title,actions: []),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Html(data: Data.settings.settings.pages[2].description,)),
    );
  }
}
