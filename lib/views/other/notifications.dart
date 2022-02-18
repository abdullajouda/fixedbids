import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/controllers/jobs_controller.dart';
import 'package:fixed_bids/models/notification.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/models/responses/notifications_response.dart';
import 'package:fixed_bids/views/other/customer/contractor_profile.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:fixed_bids/widgets/no_data_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_localization/easy_localization.dart';
import '../../utils/constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future _future;

  @override
  void initState() {
    _future = GlobalController().myNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Notification'.tr(), actions: []),
      body: FutureBuilder<NotificationsResponse>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 22)
                .add(EdgeInsets.only(bottom: 25)),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:snapshot.data.items.isEmpty?NoDataFound(): ListView.builder(
                itemCount: snapshot.data.items.length,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContractorProfile(
                            offerId: snapshot.data.items[index].orderId,
                            id: snapshot.data.items[index].fromUserId,
                          ),
                        ));
                  },
                  child: notificationBox(
                    notification: snapshot.data.items[index],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget notificationBox({NotificationModel notification}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Data.size.width * .5,
                      child: Text.rich(
                        TextSpan(
                            text: notification.fromUser.name,
                            style: Constants.applyStyle(
                              size: 16,
                              fontWeight: FontWeight.w600,
                              color: notification.seen == 1
                                  ? Color(0xff717171)
                                  : kAppbarTitleColor,
                            ),
                            children: [
                              TextSpan(text: ' '),
                              TextSpan(
                                text: notification.message1,
                                style: Constants.applyStyle(
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: notification.seen == 1
                                      ? Color(0xff717171)
                                      : kAppbarTitleColor,
                                ),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: notification.coloredMessage,
                                style: Constants.applyStyle(
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                  color: notification.seen == 1
                                      ? Color(0xff717171)
                                      : kPrimaryColor,
                                ),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: notification.message2,
                                style: Constants.applyStyle(
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: notification.seen == 1
                                      ? Color(0xff717171)
                                      : kAppbarTitleColor,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (notification.messagType == 'offer')
                      Row(
                        children: [
                          button(
                            title: 'Accept'.tr(),
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => StatefulBuilder(
                                  builder: (context, setState) =>
                                      CupertinoAlertDialog(
                                    title: Text(
                                      'Are you sure you want to accept this job offer?'
                                          .tr(),
                                    ),
                                    actions: [
                                      CupertinoButton(
                                        onPressed: () async {
                                          ApiResponse response =
                                              await JobsController()
                                                  .jobOfferAction(
                                                      status: 2,
                                                      id: notification.orderId);
                                          BotToast.showText(
                                              text: response.message);
                                          if (response.status) {
                                            Navigator.of(context).pop(true);
                                          }
                                        },
                                        child: Text(
                                          'Confirm'.tr(),
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                      CupertinoButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: TextStyle(
                                                color: Colors.red[900]),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          button(
                            title: 'Decline'.tr(),
                            color: Colors.white,
                            fontColor: HexColor('#818181'),
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => StatefulBuilder(
                                  builder: (context, setState) =>
                                      CupertinoAlertDialog(
                                    title: Text(
                                      'Are you sure you want to reject this job offer?'
                                          .tr(),
                                    ),
                                    actions: [
                                      CupertinoButton(
                                          onPressed: () async {
                                            ApiResponse response =
                                                await JobsController()
                                                    .jobOfferAction(
                                                        status: 3,
                                                        id: notification
                                                            .orderId);
                                            BotToast.showText(
                                                text: response.message);
                                            if (response.status) {
                                              Navigator.of(context).pop(true);
                                            }
                                          },
                                          child: Text('Confirm'.tr(),
                                              style: TextStyle(
                                                  color: kPrimaryColor))),
                                      CupertinoButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: TextStyle(
                                                color: Colors.red[900]),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                  ],
                ),
              ],
            ),
            Text(
              '${DateTime.now().subtract(Duration(minutes: 10)).minute < 10 ? 'Just now'.tr() : timeago.format(DateTime.now().subtract(
                    Duration(minutes: 10),
                  ), locale: 'en_short')}',
              style: notification.seen == 1
                  ? TextStyle(
                      color: Color(0xffa5a5a5), fontSize: 12, height: 1.5)
                  : Constants.applyStyle(size: 12).copyWith(height: 1.5),
            )
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Divider(
          thickness: 1,
          height: 0,
          color: HexColor('#EDECEC'),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget button(
      {String title, VoidCallback onPressed, Color color, Color fontColor}) {
    return Material(
      color: onPressed == null ? kTextLightColor : color ?? kPrimaryColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 14,
                  color: fontColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }
}
