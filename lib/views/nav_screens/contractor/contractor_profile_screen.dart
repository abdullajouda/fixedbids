import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/profile_response.dart';
import 'package:fixed_bids/views/other/contractor/edit_my_services.dart';
import 'package:fixed_bids/views/other/contractor/edit_profile.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractorProfileScreen extends StatefulWidget {
  const ContractorProfileScreen({Key key}) : super(key: key);

  @override
  _ContractorProfileScreenState createState() =>
      _ContractorProfileScreenState();
}

class _ContractorProfileScreenState extends State<ContractorProfileScreen> {
  Future _future;

  @override
  void initState() {
    _future = GlobalController().getProfileById(id: Data.currentUser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = buildAppBar(
      color: Colors.transparent,
      leading: MyIconButton(
        svg: 'assets/icons/Setting.svg',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContractorProfileEdit(),
            ),
          );
        },
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: FutureBuilder<ProfileResponse>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22).add(
                EdgeInsets.only(top: appbar.preferredSize.height, bottom: 30)),
            child: Column(
              children: [
                SizedBox(
                  height: 275,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 230,
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
                                Data.currentUser.name,
                                style: Constants.applyStyle(
                                  size: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                Data.currentUser.address ?? '',
                                style: Constants.applyStyle(
                                    size: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kTextLightColor),
                              ),
                              SizedBox(
                                height: 27,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data.item.completeJobCount
                                            .toString(),
                                        style: Constants.applyStyle(
                                          size: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Job Done'.tr(),
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
                                        snapshot.data.item.rate.toString(),
                                        style: Constants.applyStyle(
                                          size: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Avg. Ratings'.tr(),
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
                                        '\$${snapshot.data.item.avgRate.toString()}',
                                        style: Constants.applyStyle(
                                          size: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'St. Rate'.tr(),
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
                            color: purpleColor,
                            image: DecorationImage(
                                image: NetworkImage(
                                  Data.currentUser.imageProfile,
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(9999, 9999),
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Container(
                              height: 25,
                              width: 25,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999, 9999),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999, 9999),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                        'assets/icons/camera.svg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Skills'.tr(),
                            style: Constants.applyStyle(
                              fontWeight: FontWeight.w600,
                              size: 18,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMyServices(
                                      services: snapshot.data.item.servises,
                                    ),
                                  )).then((value) {
                                setState(() {
                                  _future = GlobalController()
                                      .getProfileById(id: Data.currentUser.id);
                                });
                              });
                            },
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Edit'.tr(),
                              style: Constants.applyStyle(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          snapshot.data.item.servises.length,
                          (index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(232, 241, 255, 1)),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 7.5),
                            child: Text(
                              snapshot.data.item.servises[index].service.name ??
                                  '',
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
                        'Client Reviews'.tr(),
                        style: Constants.applyStyle(
                          fontWeight: FontWeight.w600,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        itemCount: snapshot.data.item.reviews.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor.withOpacity(0.2),
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data
                                              .item
                                              .reviews[index]
                                              .user
                                              .imageProfile),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999, 9999),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot
                                            .data.item.reviews[index].user.name,
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
                                            snapshot
                                                .data.item.reviews[index].rate
                                                .toString(),
                                            style: Constants.applyStyle(
                                                fontWeight: FontWeight.w600,
                                                size: 14,
                                                color: kPrimaryColor),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          RatingBar.builder(
                                            initialRating: snapshot
                                                .data.item.reviews[index].rate
                                                .toDouble(),
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
                                            ignoreGestures: true,
                                            onRatingUpdate: (rating) {},
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
                                snapshot.data.item.reviews[index].comment,
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
          );
        },
      ),
    );
  }
}
