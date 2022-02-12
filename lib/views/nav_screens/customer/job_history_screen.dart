import 'dart:math';

import 'package:fixed_bids/controllers/user_controller.dart';
import 'package:fixed_bids/models/job.dart';
import 'package:fixed_bids/models/responses/nearby_jobs_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fixed_bids/views/other/customer/job_details.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobHistoryScreen extends StatefulWidget {
  const JobHistoryScreen({Key key}) : super(key: key);

  @override
  _JobHistoryScreenState createState() => _JobHistoryScreenState();
}

class _JobHistoryScreenState extends State<JobHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future _openFuture;
  Future _closedFuture;
  RefreshController _openRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController _closedRefreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      _openFuture = UserController().getMyJobsByUser();
      _closedFuture = UserController().getMyJobsByUser(isOpen: 0);
    });

    _openRefreshController.refreshCompleted();
    _closedRefreshController.refreshCompleted();
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _openFuture = UserController().getMyJobsByUser();
    _closedFuture = UserController().getMyJobsByUser(isOpen: 0);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder<NearByJobsResponse>(
                  future: _openFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loading();
                    }
                    return SmartRefresher(
                      controller: _openRefreshController,
                      onRefresh: _onRefresh,
                      child: ListView.separated(
                        itemCount: snapshot.data.items.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                        itemBuilder: (context, index) =>
                            buildJobBox(job: snapshot.data.items[index]),
                      ),
                    );
                  }),
              FutureBuilder<NearByJobsResponse>(
                future: _closedFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(child: Loading());
                  }
                  return SmartRefresher(
                    controller: _closedRefreshController,
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      itemCount: snapshot.data.items.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemBuilder: (context, index) =>
                          buildJobBox(job: snapshot.data.items[index]),
                    ),
                  );
                },
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildJobBox({Job job}) {
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
                  builder: (context) => JobDetails(
                    id: job.id,
                  ),
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
                    image: NetworkImage(job.image),
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
                        '${job.status}',
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
                          job.title,
                          style: Constants.applyStyle(
                              size: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$${job.price}',
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
                          timeago.format(job.createdAt),
                          style: Constants.applyStyle(
                              size: 14, color: HexColor('A6A6A6')),
                        ),
                        Text('  •  '),
                        Text(
                          job.urgencyType == 1
                              ? 'LOW'
                              : job.urgencyType == 2
                                  ? 'HIGH'
                                  : 'EMERGENCY',
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
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(job.user.imageProfile)),
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
                                        '${job.user.rate}',
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
                                  '${job.user.name}',
                                  style: Constants.applyStyle(
                                      fontWeight: FontWeight.w600, size: 18),
                                ),
                                SizedBox(
                                  height: 12.8,
                                ),
                                if (job.user.servises != null &&
                                    job.user.servises.isNotEmpty)
                                  LayoutBuilder(
                                    builder: (context, constraints) =>
                                        SizedOverflowBox(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      size: Size(constraints.minWidth, 23),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              constraints.isSatisfiedBy(Size(
                                                      constraints.minWidth - 10,
                                                      23))
                                                  ? job.user.servises.length
                                                  : 1,
                                              (index) => Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Color.fromRGBO(
                                                            232, 241, 255, 1)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 7.5),
                                                    child: Text(
                                                      '${job.service.name}',
                                                      style:
                                                          Constants.applyStyle(
                                                              size: 12,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      31,
                                                                      113,
                                                                      237,
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
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
                                                '${job.user.servises.length - 1}+',
                                                style: Constants.applyStyle(
                                                    size: 12,
                                                    color: Color.fromRGBO(
                                                        31, 113, 237, 1),
                                                    fontWeight:
                                                        FontWeight.w400),
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
