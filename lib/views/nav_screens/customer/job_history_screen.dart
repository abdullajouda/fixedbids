import 'dart:math';

import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/external/lib/src/components/animated_pin.dart';
import 'package:fixed_bids/views/other/customer/create_job.dart';
import 'package:fixed_bids/views/other/customer/job_details.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class JobHistoryScreen extends StatefulWidget {
  const JobHistoryScreen({Key key}) : super(key: key);

  @override
  _JobHistoryScreenState createState() => _JobHistoryScreenState();
}

class _JobHistoryScreenState extends State<JobHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List test = [
    'home cleaning',
    'ac servicing',
    'car repair',
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 0)
                ],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Color(0x0ffADAAAA),
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 0.1,
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: Colors.transparent,
                onTap: (value) {
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                          color: _tabController.index == 0
                              ? kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          'Open',
                          style: TextStyle(
                            color: _tabController.index == 0
                                ? Colors.white
                                : Color(0x0ffADAAAA),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                          color: _tabController.index == 1
                              ? kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          'Closed',
                          style: TextStyle(
                            color: _tabController.index == 1
                                ? Colors.white
                                : Color(0x0ffADAAAA),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController,
            children: [
              ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) => buildJobBox(),
              ),
              ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) => buildJobBox(),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildJobBox() {
    return Container(
      // height: 369,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetails(),
                ));
          },
          child: Column(
            children: [
              Container(
                height: 174,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY6nriKa13M9mOT9enoiRVTnQK1TmzcZKq5DI8YbsIVcdnrLO_9oQlw5sslR6SQ-yGrB8&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                      child: Text(
                        'Open',
                        style: Constants.applyStyle(
                            color: Colors.white,
                            size: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Need to Clean Bed Room',
                          style: Constants.applyStyle(
                              size: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$120',
                          style: Constants.applyStyle(
                              size: 20,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Yesterday',
                          style: Constants.applyStyle(
                              size: 14, color: HexColor('A6A6A6')),
                        ),
                        Text('  •  '),
                        Text(
                          'EMERGENCY',
                          style: Constants.applyStyle(
                              size: 14,
                              color: HexColor('19A716'),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                      height: 0,
                      color: HexColor('#EDECEC'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: purpleColor,
                                borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999, 9999),
                                ),
                              ),
                              child: Transform.translate(
                                offset: Offset(0, 3),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 17.8,
                                    width: 31,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '4.9',
                                        style: Constants.applyStyle(
                                            color: Colors.white,
                                            size: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Monalisa Paul',
                                  style: Constants.applyStyle(
                                      fontWeight: FontWeight.w600, size: 18),
                                ),
                                SizedBox(
                                  height: 12.8,
                                ),
                                LayoutBuilder(
                                  builder: (context, constraints) =>
                                      SizedOverflowBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    size: Size(constraints.minWidth, 23),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                            constraints.isSatisfiedBy(Size(
                                                    constraints.minWidth - 10,
                                                    23))
                                                ? test.length
                                                : 1,
                                            (index) => Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Color.fromRGBO(
                                                          232, 241, 255, 1)),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 7.5),
                                                  child: Text(
                                                    'home cleaning',
                                                    style: Constants.applyStyle(
                                                        size: 12,
                                                        color: Color.fromRGBO(
                                                            31, 113, 237, 1),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (!constraints.isSatisfiedBy(Size(
                                            constraints.minWidth - 10, 23)))
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromRGBO(
                                                    232, 241, 255, 1)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 7.5),
                                            child: Text(
                                              '${test.length - 1}+',
                                              style: Constants.applyStyle(
                                                  size: 12,
                                                  color: Color.fromRGBO(
                                                      31, 113, 237, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            MyIconButton(
                              svg: 'assets/icons/Chat.svg',
                              color: HexColor('#1F71ED').withOpacity(0.15),
                              iconColor: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            MyIconButton(
                              svg: 'assets/icons/Calling.svg',
                              color: HexColor('#1F71ED').withOpacity(0.15),
                              iconColor: kPrimaryColor,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
