import 'package:fixed_bids/models/responses/user_by_service_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';
import 'package:fixed_bids/views/other/customer/contractor_profile.dart';
import 'package:fixed_bids/views/other/customer/service_contractors.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:fixed_bids/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;
  int _selectedCategory = 0;
  Future _adsFuture;
  Future _future;

  @override
  void initState() {
    _adsFuture = GlobalController().getBanners();
    _future =
        GlobalController().getUsersByServiceId(id: Data.services.items[0].id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Color(0x0ffF8F8F8),
        leadingWidth: 90,
        leading: Center(
          child: Container(
            height: 45,
            width: 45,
            margin: EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: Color(0x0ffF1F1F1),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(
                    Data.currentUser.imageProfile,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        title: Text(
          '${'Hi'.tr()}, ${Data.currentUser.name}',
          style: Constants.applyStyle(size: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          MyIconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceProviders(),
                  ));
            },
            svg: 'assets/icons/Search.svg',
          ),
          SizedBox(
            width: 10,
          ),
          Center(child: NotificationButton()),
          SizedBox(
            width: 22,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<BannersResponse>(
              future: _adsFuture,
              builder: (context, snapshot) {
                return AnimatedScale(
                  scale: snapshot.hasData ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  child: !snapshot.hasData
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: SizedBox(
                                  width: Data.size.width,
                                  height: Data.size.width * 0.5,
                                  child: PageView.builder(
                                    onPageChanged: (value) {
                                      setState(() {
                                        _currentIndex = value;
                                      });
                                    },
                                    itemCount: snapshot.data.items.length,
                                    itemBuilder: (context, index) =>
                                        Image.network(
                                      snapshot.data.items[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                    snapshot.data.items.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.fastOutSlowIn,
                                      height: 7,
                                      width: _currentIndex == index ? 24 : 7,
                                      decoration: BoxDecoration(
                                          color: _currentIndex == index
                                              ? Color(0x0ff263238)
                                              : grayColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
            SizedBox(
              height: Data.size.width * .1,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  // Material(
                  //   borderRadius: BorderRadius.circular(18),
                  //   color:
                  //       _selectedCategory == -1 ? kPrimaryColor : Colors.white,
                  //   child: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         _selectedCategory = -1;
                  //         _future =
                  //             GlobalController().getUsersByServiceId(id: 0);
                  //       });
                  //     },
                  //     borderRadius: BorderRadius.circular(18),
                  //     child: Container(
                  //       height: 45,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(18),
                  //       ),
                  //       padding: EdgeInsets.symmetric(horizontal: 20),
                  //       child: Center(
                  //         child: Text(
                  //           'All',
                  //           style: Constants.applyStyle(
                  //             size: 14,
                  //             color: _selectedCategory == -1
                  //                 ? Colors.white
                  //                 : Colors.black,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Row(
                    children: List.generate(
                      Data.services.items.length,
                      (index) => Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(18),
                            color: _selectedCategory == index
                                ? kPrimaryColor
                                : Colors.white,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = index;
                                  _future = GlobalController()
                                      .getUsersByServiceId(
                                          id: Data.services.items[index].id);
                                });
                              },
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 13),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        child: Image.network(
                                          Data.services.items[index].image,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  SizedBox(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        Data.services.items[index].name,
                                        style: Constants.applyStyle(
                                          color: _selectedCategory == index
                                              ? Colors.white
                                              : Colors.black,
                                          size: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Data.size.width * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                '${'Recommended For You'.tr()} 👍',
                style:
                    Constants.applyStyle(size: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: Data.size.width * .05,
            ),
            FutureBuilder<UsersByServiceResponse>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      height: Data.size.height * .3, child: Loading());
                }
                return ListView.separated(
                  itemCount: snapshot.data.items.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (context, index) => Container(
                    // height: 132,
                    margin: EdgeInsets.only(bottom: 10),
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
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContractorProfile(
                                id: snapshot.data.items[index].id,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  snapshot.data.items[index].imageProfile,
                                  height: 122,
                                  width: 105,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data.items[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: Constants.applyStyle(
                                                size: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: kPrimaryColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot.data.items[index].rate
                                                  .toString(),
                                              style: Constants.applyStyle(
                                                size: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                          text: 'St. Rate'.tr(),
                                          children: [
                                            TextSpan(text: ' '),
                                            TextSpan(
                                              text:
                                                  '\$${snapshot.data.items[index].avgRate}',
                                              style: Constants.applyStyle(
                                                size: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0x0ff1F71ED),
                                              ),
                                            ),
                                          ]),
                                      style: Constants.applyStyle(
                                        size: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0x0ff9F9F9F),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
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
                                                        constraints.minWidth -
                                                            10,
                                                        23))
                                                    ? snapshot.data.items[index]
                                                        .servises.length
                                                    : 1,
                                                (idx) => Row(
                                                  children: [
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
                                                        snapshot.data.items[index]
                                                            .servises[idx].service.name,
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
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Color.fromRGBO(
                                                        232, 241, 255, 1)),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 7.5),
                                                child: Text(
                                                  '${snapshot.data.items[index].servises.length - 1}+',
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: Data.size.width * .05,
            ),
          ],
        ),
      ),
    );
  }
}
