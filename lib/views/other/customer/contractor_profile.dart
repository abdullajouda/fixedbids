import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ContractorProfile extends StatefulWidget {
  final int withRequest;

  const ContractorProfile({Key key, this.withRequest = 0}) : super(key: key);

  @override
  _ContractorProfileState createState() => _ContractorProfileState();
}

class _ContractorProfileState extends State<ContractorProfile> {
  int actionTaken = 0;

  List test = [
    'home cleaning',
    'ac servicing',
    'car repair',
  ];

  @override
  Widget build(BuildContext context) {
    AppBar appbar = buildAppBar(color: Colors.transparent);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 22)
            .add(EdgeInsets.only(top: appbar.preferredSize.height, bottom: 30)),
        child: Column(
          children: [
            SizedBox(
              height: 345,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ],
                      ),
                      padding: EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Text(
                            'Manua Vatar',
                            style: Constants.applyStyle(
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Los Angeles, CA 90001',
                            style: Constants.applyStyle(
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextLightColor),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '345',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Job Done',
                                    style: Constants.applyStyle(
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('655D64'),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '4.5',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Avg. Ratings',
                                    style: Constants.applyStyle(
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('655D64'),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '\$29',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'St. Rate',
                                    style: Constants.applyStyle(
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('655D64'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: actionTaken == 1
                                ? Button(
                                    title: 'Message',
                                    onPressed: () {},
                                  )
                                : Row(
                                    children: [
                                      if (widget.withRequest == 1)
                                        Expanded(
                                          child: Button(
                                            title: 'Action',
                                            onPressed: () {
                                              setState(() {
                                                actionTaken = 1;
                                              });
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                enableDrag: true,
                                                barrierColor:
                                                    Colors.transparent,
                                                builder: (context) => Container(
                                                  // constraints:
                                                  //     BoxConstraints(maxHeight: 200),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    30)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.05),
                                                          offset: Offset(0, 4),
                                                          blurRadius: 10,
                                                          spreadRadius: 0)
                                                    ],
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 22,
                                                      vertical: 27),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Button(
                                                        title: 'Accept',
                                                        onPressed: () {},
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Button(
                                                        title: 'Decline',
                                                        color: Colors.white,
                                                        fontColor:
                                                            HexColor('#263238'),
                                                        hasBorder: true,
                                                        onPressed: () {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      else
                                        Expanded(
                                          child: Button(
                                            title: 'Message',
                                            onPressed: () {},
                                          ),
                                        ),
                                      SizedBox(
                                        width: 11,
                                      ),
                                      if (widget.withRequest == 1)
                                        Expanded(
                                          child: Button(
                                            title: 'Message',
                                            color: Colors.white,
                                            fontColor: HexColor('#263238'),
                                            hasBorder: true,
                                            onPressed: () {},
                                          ),
                                        )
                                      else
                                        Expanded(
                                          child: Button(
                                            title: 'Hire Me',
                                            color: Colors.white,
                                            fontColor: HexColor('#263238'),
                                            hasBorder: true,
                                            onPressed: () {},
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(9999, 9999),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 0)
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Skills',
                    style: Constants.applyStyle(
                      fontWeight: FontWeight.w600,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      test.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(232, 241, 255, 1)),
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 7.5),
                        child: Text(
                          'home cleaning',
                          style: Constants.applyStyle(
                              size: 12,
                              color: Color.fromRGBO(31, 113, 237, 1),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: HexColor(
                      '#EDECEC',
                    ),
                    thickness: 1,
                    height: 0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Client Reviews',
                    style: Constants.applyStyle(
                      fontWeight: FontWeight.w600,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999, 9999),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shah Baru',
                                    style: Constants.applyStyle(
                                      fontWeight: FontWeight.w600,
                                      size: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '5.0',
                                        style: Constants.applyStyle(
                                            fontWeight: FontWeight.w600,
                                            size: 14,
                                            color: kPrimaryColor),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        itemSize: 13.45,
                                        itemCount: 5,
                                        unratedColor: HexColor('D0D0D0'),
                                        glowColor: kPrimaryColor,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: kPrimaryColor,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Need more choices, and in the morning should open before. It needs to either have a buffet service or faster serving time.',
                            style: Constants.applyStyle(
                                color: HexColor('#655D64'), size: 16),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
