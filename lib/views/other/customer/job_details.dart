import 'package:fixed_bids/controllers/jobs_controller.dart';
import 'package:fixed_bids/models/job.dart';
import 'package:fixed_bids/models/responses/job_id_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/other/customer/create_job.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;


class JobDetails extends StatefulWidget {
  final int id;

  const JobDetails({Key key, this.id}) : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  Future _future;
  Job _job;

  @override
  void initState() {
    _future = JobsController().getJobId(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Job details'),
      body: FutureBuilder<JobDetailsResponse>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          _job = snapshot.data.item;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22)
                .add(EdgeInsets.only(bottom: 120)),
            child: Column(
              children: [
                Container(
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
                  child: Column(
                    children: [
                      Container(
                        height: 174,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data.item.image),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 4),
                              child: Text(
                                '${snapshot.data.item.status}',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.item.title,
                                  style: Constants.applyStyle(
                                      size: 20, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '\$${snapshot.data.item.price}',
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
                                  timeago.format(snapshot.data.item.createdAt),
                                  style: Constants.applyStyle(
                                      size: 14, color: HexColor('A6A6A6')),
                                ),
                                Text('  •  '),
                                Text(
                                  snapshot.data.item.urgencyType == 1
                                      ? 'LOW'
                                      : snapshot.data.item.urgencyType == 2
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
                                            image: NetworkImage(snapshot
                                                .data.item.user.imageProfile)),
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
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${snapshot.data.item.user.rate}',
                                                style: Constants.applyStyle(
                                                    color: Colors.white,
                                                    size: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data.item.user.name}',
                                          style: Constants.applyStyle(
                                              fontWeight: FontWeight.w600,
                                              size: 18),
                                        ),
                                        SizedBox(
                                          height: 12.8,
                                        ),
                                        if (snapshot.data.item.user.servises !=
                                                null &&
                                            snapshot.data.item.user.servises
                                                .isNotEmpty)
                                          LayoutBuilder(
                                            builder: (context, constraints) =>
                                                SizedOverflowBox(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              size: Size(
                                                  constraints.minWidth, 23),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: List.generate(
                                                      constraints.isSatisfiedBy(
                                                              Size(
                                                                  constraints
                                                                          .minWidth -
                                                                      10,
                                                                  23))
                                                          ? snapshot
                                                              .data
                                                              .item
                                                              .user
                                                              .servises
                                                              .length
                                                          : 1,
                                                      (index) => Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: Color
                                                                    .fromRGBO(
                                                                        232,
                                                                        241,
                                                                        255,
                                                                        1)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        7.5),
                                                            child: Text(
                                                              '${snapshot.data.item.service.name}',
                                                              style: Constants.applyStyle(
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
                                                  if (!constraints
                                                      .isSatisfiedBy(Size(
                                                          constraints.minWidth -
                                                              10,
                                                          23)))
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Color.fromRGBO(
                                                              232,
                                                              241,
                                                              255,
                                                              1)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4,
                                                              horizontal: 7.5),
                                                      child: Text(
                                                        '${snapshot.data.item.user.servises.length - 1}+',
                                                        style: Constants
                                                            .applyStyle(
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
                                      color:
                                          HexColor('#1F71ED').withOpacity(0.15),
                                      iconColor: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MyIconButton(
                                      svg: 'assets/icons/Calling.svg',
                                      color:
                                          HexColor('#1F71ED').withOpacity(0.15),
                                      iconColor: kPrimaryColor,
                                    )
                                  ],
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
                              height: 23,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    'Job description',
                                    style: Constants.applyStyle(
                                        fontWeight: FontWeight.w600, size: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.... Read more',
                                  style: Constants.applyStyle(
                                    size: 14,
                                  ).copyWith(height: 1.5),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 26.5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    'Photos',
                                    style: Constants.applyStyle(
                                        fontWeight: FontWeight.w600, size: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GridView.builder(
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 1.5),
                                  itemBuilder: (context, index) => Container(
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: purpleColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Button(
                    title: 'Edit',
                    onPressed: _job == null
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateJob(
                                    job: _job,
                                  ),
                                ));
                          },
                  ),
                ),
              ),
              SizedBox(
                width: 17,
              ),
              SizedBox(
                width: 67,
                height: 50,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                    onTap:_job == null
                        ? null
                        :  () {
                      JobsController().deleteJobById(id: _job.id);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            color: HexColor('#E2E2E2'),
                            width: 1,
                          )),
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 18,
                          child: SvgPicture.asset('assets/icons/trash.svg'),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
