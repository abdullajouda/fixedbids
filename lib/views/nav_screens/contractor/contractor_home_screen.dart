import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/controllers/provider_controller.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';
import 'package:fixed_bids/models/responses/nearby_jobs_response.dart';
import 'package:fixed_bids/views/other/contractor/contractor_job_details.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/no_data_found.dart';
import 'package:fixed_bids/widgets/notification_button.dart';
import 'package:fixed_bids/widgets/something_went_wrong.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractorHomeScreen extends StatefulWidget {
  const ContractorHomeScreen({Key key}) : super(key: key);

  @override
  _ContractorHomeScreenState createState() => _ContractorHomeScreenState();
}

class _ContractorHomeScreenState extends State<ContractorHomeScreen> {
  int _currentIndex = 0;
  Future _adsFuture;
  Future _future;
  LocationPermission locationEnabled = LocationPermission.denied;
  bool gpsEnabled = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      _future = ProviderController().nearbyJobs();
      _adsFuture = GlobalController().getBanners();
    });

    _refreshController.refreshCompleted();
  }

  Future checkPermission() async {
    locationEnabled = await Geolocator.checkPermission();
    gpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationEnabled != LocationPermission.denied &&
        locationEnabled != LocationPermission.deniedForever &&
        gpsEnabled) {
      Position position = await Geolocator
          .getCurrentPosition();
      setState(() {
        _future = ProviderController()
            .nearbyJobs(
            lng: position.longitude,
            lat: position.latitude);
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    checkPermission();
    _adsFuture = GlobalController().getBanners();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Center(child: NotificationButton()),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
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
                                          width:
                                              _currentIndex == index ? 24 : 7,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    '${'Nearby Jobs For You'.tr()} 🙂',
                    style: Constants.applyStyle(
                        size: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: Data.size.width * .05,
                ),
                Builder(builder: (context) {
                  if (locationEnabled == LocationPermission.denied ||
                      !gpsEnabled) {
                    return SizedBox(
                      height: Data.size.height * .4,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Please Make Sure The Gps Is Enabled'.tr(),
                                style: Constants.applyStyle(
                                    fontWeight: FontWeight.w700,
                                    color: kPrimaryColor,
                                    size: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (Platform.isAndroid)
                              SizedBox(
                                height: 50,
                              ),
                            if (Platform.isAndroid)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Button(
                                  title: 'Go To Settings'.tr(),
                                  onPressed: () async {
                                    if (Platform.isAndroid) {
                                      Geolocator.openAppSettings()
                                          .then((value) async {
                                        if (value) {
                                          Position position = await Geolocator
                                              .getCurrentPosition();
                                          setState(() {
                                            _future = ProviderController()
                                                .nearbyJobs(
                                                    lng: position.longitude,
                                                    lat: position.latitude);
                                          });
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                  return FutureBuilder<NearByJobsResponse>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                              height: Data.size.height * .4, child: Loading());
                        }
                        if (snapshot.hasError) {
                          return SizedBox(
                              height: Data.size.height * .4,
                              child: SomethingWentWrong(
                                onPressed: () {
                                  setState(() {
                                    _future = ProviderController().nearbyJobs();
                                  });
                                },
                              ));
                        }
                        if (snapshot.data.items.isEmpty) {
                          return SizedBox(
                              height: Data.size.height * .4,
                              child: NoDataFound());
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  color: Color.fromRGBO(0, 0, 0, 0.05),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ContractorJobDetails(
                                            id: snapshot.data.items[index].id,
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 19, vertical: 16)
                                        .add(EdgeInsets.only(bottom: 8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      snapshot.data.items[index]
                                                          .user.imageProfile),
                                                  backgroundColor:
                                                      kPrimaryColor,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  snapshot.data.items[index]
                                                      .user.name,
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#818181'),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                            Text(
                                              '\$${snapshot.data.items[index].price}',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          snapshot.data.items[index].title,
                                          style: TextStyle(
                                              color: HexColor('#3F3F3F'),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              timeago.format(snapshot
                                                  .data.items[index].createdAt),
                                              style: TextStyle(
                                                  color: HexColor('#A6A6A6'),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Color.fromRGBO(
                                                      232, 241, 255, 1)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 7.5),
                                              child: Text(
                                                snapshot.data.items[index]
                                                    .service.name,
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
                SizedBox(
                  height: Data.size.width * .05,
                ),
              ],
            ),
          ),
        ));
  }
}
