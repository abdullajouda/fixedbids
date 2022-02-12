import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'create_job.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({Key key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x0ffF8F8F8),
      appBar: buildAppBar(title: 'Choose category'),
      body: ListView.separated(
        itemCount: Data.services.items.length,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) => Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 0)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateJob(
                          id: Data.services.items[index].id,
                        ),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Text(
                        Data.services.items[index].name,
                        style: Constants.applyStyle(
                            color: kAppbarTitleColor,
                            size: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Image.network(
                      Data.services.items[index].image,
                      errorBuilder: (context, error, stackTrace) => SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
