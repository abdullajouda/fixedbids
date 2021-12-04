import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'job_published.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({Key key}) : super(key: key);

  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Job details'),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              buildContainer(
                  title: 'Photo',
                  body: CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      onPressed: () {},
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset('assets/images/blue_box.svg'),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset('assets/icons/images.svg'),
                              SizedBox(
                                width: 12,
                              ),
                              Text('Upload a photo')
                            ],
                          )
                        ],
                      ))),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Job title',
                      style: Constants.applyStyle(
                          size: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: inputDecoration(hint: 'Type here'),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Text(
                      'Urgency',
                      style: Constants.applyStyle(
                          size: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField(
                      items: [],
                      decoration: inputDecoration(hint: 'Select'),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Text(
                      'Location',
                      style: Constants.applyStyle(
                          size: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: inputDecoration(hint: 'Enter ZIP code'),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                  ],
                ),
              ),
              buildContainer(
                  title: 'How much are you willing to pay?',
                  body: TextFormField(
                    decoration: inputDecoration(
                        hint: 'Type amount here', prefix: Text('\$ ')),
                  )),
              buildContainer(
                  title: 'Details',
                  body: TextFormField(
                    maxLines: 5,
                    decoration: fatInputDecoration(
                      hint: 'Type details',
                    ),
                  )),
              SizedBox(
                height: 100,
              )
            ],
          )),
      bottomSheet: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 0)
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Center(
          child: Button(
            title: 'Publish',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobPublished(),
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget buildContainer({@required String title, Widget body}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Constants.applyStyle(size: 18, fontWeight: FontWeight.w500),
          ),
          if (body != null)
            SizedBox(
              height: 20,
            ),
          body ?? SizedBox(),
          if (body != null)
            SizedBox(
              height: 10,
            ),
        ],
      ),
    );
  }
}
