import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/notification.dart';
import 'package:fixed_bids/models/responses/notifications_response.dart';
import 'package:fixed_bids/views/other/customer/contractor_profile.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

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
      appBar: buildAppBar(title: 'Notification', actions: []),
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
              child: ListView.builder(
                  itemCount: snapshot.data.items.length,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContractorProfile(withRequest: 1,id: snapshot.data.items[index].userId,),
                            ));
                      },
                      child: notificationBox(notification: snapshot.data.items[index]))),
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
                            text: 'Ayub khanna',
                            style: Constants.applyStyle(
                              size: 16,
                              fontWeight: FontWeight.w600,
                              color: kAppbarTitleColor,
                            ),
                            children: [
                              TextSpan(text: ' '),
                              TextSpan(
                                text: notification.message,
                                style: Constants.applyStyle(
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kAppbarTitleColor,
                                ),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: 'Handy Man',
                                style: Constants.applyStyle(
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: 'job',
                                style: Constants.applyStyle(
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kAppbarTitleColor,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        button(
                          title: 'Accept',
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        button(
                          title: 'Decline',
                          color: Colors.white,
                          fontColor: HexColor('#818181'),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Text(
              '${DateTime.now().subtract(Duration(minutes: 10)).minute < 10 ? 'Just now' : timeago.format(DateTime.now().subtract(
                    Duration(minutes: 10),
                  ), locale: 'en_short')}',
              style: Constants.applyStyle(size: 12).copyWith(height: 1.5),
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
