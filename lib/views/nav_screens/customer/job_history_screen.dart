import 'dart:math';

import 'package:fixed_bids/constants.dart';
import 'package:flutter/material.dart';

class JobHistoryScreen extends StatefulWidget {
  const JobHistoryScreen({Key key}) : super(key: key);

  @override
  _JobHistoryScreenState createState() => _JobHistoryScreenState();
}

class _JobHistoryScreenState extends State<JobHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kBackGroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0x0ffADAAAA),
              indicatorPadding: EdgeInsets.zero,
              indicatorWeight: 0.1,
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
          Expanded(
            child: AnimatedBuilder(
              animation: _tabController.animation,
              builder: (BuildContext context, snapshot) {
                return Transform.rotate(
                  angle: _tabController.animation.value * pi,
                  child: [
                    Container(
                      color: Colors.blue,
                    ),
                    Container(
                      color: Colors.orange,
                    ),
                  ][_tabController.animation.value.round()],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
