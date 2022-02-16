import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/chat_controller.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/controllers/jobs_controller.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/models/responses/profile_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/other/open_chat.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:fixed_bids/widgets/no_data_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractorProfile extends StatefulWidget {
  final int offerId;
  final int id;

  const ContractorProfile({Key key, this.offerId, this.id}) : super(key: key);

  @override
  _ContractorProfileState createState() => _ContractorProfileState();
}

class _ContractorProfileState extends State<ContractorProfile> {
  Future _future;
  bool loadChat = false;

  @override
  void initState() {
    _future = GlobalController().getProfileById(id: Data.currentUser.id);
    super.initState();
  }

  int actionTaken = 0;

  @override
  Widget build(BuildContext context) {
    AppBar appbar = buildAppBar(color: Colors.transparent);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: FutureBuilder<ProfileResponse>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            var user = snapshot.data.item;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22).add(EdgeInsets.only(
                  top: appbar.preferredSize.height, bottom: 30)),
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
                                  user.name,
                                  style: Constants.applyStyle(
                                    size: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  user.address,
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
                                          user.completeJobCount.toString(),
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
                                          '${user.rate}',
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
                                          '\$${user.avgRate != 'null' ? user.avgRate : '0'}',
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: actionTaken == 1
                                      ? Button(
                                          title: 'Message'.tr(),loading: loadChat,
                                    onPressed: () async {
                                      setState(() {
                                        loadChat = true;
                                      });
                                      ApiResponse response = await ChatController()
                                          .checkChat(id: user.id);
                                      setState(() {
                                        loadChat = false;
                                      });
                                      if (response.status) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OpenChat(
                                              id: response.chatID,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                        )
                                      : Row(
                                          children: [
                                            if (widget.offerId != null)
                                              Expanded(
                                                child: Button(
                                                  title: 'Action'.tr(),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      isDismissible: true,
                                                      enableDrag: true,
                                                      barrierColor:
                                                          Colors.transparent,
                                                      builder: (context) =>
                                                          Container(

                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          30)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.05),
                                                                offset: Offset(
                                                                    0, 4),
                                                                blurRadius: 10,
                                                                spreadRadius: 0)
                                                          ],
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 22,
                                                                vertical: 27),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Button(
                                                              title:
                                                                  'Accept'.tr(),
                                                              onPressed: () {
                                                                showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      true,
                                                                  builder:
                                                                      (context) =>
                                                                          StatefulBuilder(
                                                                    builder: (context,
                                                                            setState) =>
                                                                        CupertinoAlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Are you sure you want to accept this job offer?'
                                                                            .tr(),
                                                                      ),
                                                                      actions: [
                                                                        CupertinoButton(
                                                                          onPressed:
                                                                              () async {
                                                                            ApiResponse
                                                                                response =
                                                                                await JobsController().jobOfferAction(status: 2, id: widget.offerId);
                                                                            BotToast.showText(text: response.message);
                                                                            if (response.status) {
                                                                              setState(() {
                                                                                actionTaken = 1;
                                                                              });
                                                                              Navigator.of(context).pop(true);
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Confirm'.tr(),
                                                                            style:
                                                                                TextStyle(color: kPrimaryColor),
                                                                          ),
                                                                        ),
                                                                        CupertinoButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Cancel'.tr(),
                                                                            style:
                                                                                TextStyle(color: Colors.red[900]),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Button(
                                                              title: 'Decline'
                                                                  .tr(),
                                                              color:
                                                                  Colors.white,
                                                              fontColor:
                                                                  HexColor(
                                                                      '#263238'),
                                                              hasBorder: true,
                                                              onPressed: () {
                                                                showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      true,
                                                                  builder:
                                                                      (context) =>
                                                                          StatefulBuilder(
                                                                    builder: (context,
                                                                            setState) =>
                                                                        CupertinoAlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Are you sure you want to reject this job offer?'
                                                                            .tr(),
                                                                      ),
                                                                      actions: [
                                                                        CupertinoButton(
                                                                          onPressed:
                                                                              () async {
                                                                            ApiResponse
                                                                                response =
                                                                                await JobsController().jobOfferAction(status: 3, id: widget.offerId);

                                                                            BotToast.showText(text: response.message);
                                                                            if (response.status) {
                                                                              setState(() {
                                                                                actionTaken = 1;
                                                                              });
                                                                              Navigator.of(context).pop(true);
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Confirm'.tr(),
                                                                            style:
                                                                                TextStyle(color: kPrimaryColor),
                                                                          ),
                                                                        ),
                                                                        CupertinoButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Cancel'.tr(),
                                                                            style:
                                                                                TextStyle(color: Colors.red[900]),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
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
                                                  title: 'Message'.tr(),
                                                  loading: loadChat,
                                                  onPressed: () async {
                                                    setState(() {
                                                      loadChat = true;
                                                    });
                                                    ApiResponse response = await ChatController()
                                                        .checkChat(id: user.id);
                                                    setState(() {
                                                      loadChat = false;
                                                    });
                                                    if (response.status) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => OpenChat(
                                                            id: response.chatID,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            SizedBox(
                                              width: 11,
                                            ),
                                            Expanded(
                                              child: Button(
                                                title: 'Message'.tr(),
                                                color: Colors.white,
                                                fontColor: HexColor('#263238'),
                                                hasBorder: true,
                                                loading: loadChat,
                                                onPressed: () async {
                                                  setState(() {
                                                    loadChat = true;
                                                  });
                                                  ApiResponse response = await ChatController()
                                                      .checkChat(id: user.id);
                                                  setState(() {
                                                    loadChat = false;
                                                  });
                                                  if (response.status) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => OpenChat(
                                                          id: response.chatID,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            if (widget.offerId == null)
                                              Expanded(
                                                child: Button(
                                                  title: 'Hire Me'.tr(),
                                                  color: Colors.white,
                                                  fontColor:
                                                      HexColor('#263238'),
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
                              image: DecorationImage(
                                  image: NetworkImage(user.imageProfile),
                                  fit: BoxFit.cover),
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
                        if (user.servises.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skills'.tr(),
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
                                  user.servises.length,
                                  (index) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color.fromRGBO(232, 241, 255, 1)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 7.5),
                                    child: Text(
                                      'home cleaning',
                                      style: Constants.applyStyle(
                                          size: 12,
                                          color:
                                              Color.fromRGBO(31, 113, 237, 1),
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
                            ],
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
                        if (user.reviews.isEmpty)
                          NoDataFound()
                        else
                          ListView.builder(
                            itemCount: user.reviews.length,
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
                                          image: DecorationImage(
                                              image: NetworkImage(user
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
                                            user.reviews[index].user.name,
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
                                                user.reviews[index].rate
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
                                                initialRating: double.parse(user
                                                    .reviews[index].rate
                                                    .toString()),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                itemSize: 13.45,
                                                itemCount: 5,
                                                unratedColor:
                                                    HexColor('D0D0D0'),
                                                glowColor: kPrimaryColor,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: kPrimaryColor,
                                                ),
                                                ignoreGestures: true,
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
                                    user.reviews[index].comment,
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
          }),
    );
  }
}
