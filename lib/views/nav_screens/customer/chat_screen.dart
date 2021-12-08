import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/other/open_chat.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 0)
                ],
              ),
              child: TextFormField(
                decoration:
                    searchInputDecoration(hint: 'Search user or message'),
              )),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 10, right: 22, left: 22),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                itemBuilder: (context, index) => Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OpenChat(),));
                        },
                        splashColor: kPrimaryColor,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: purpleColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999, 9999),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                    child: Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: HexColor('#27C837'),
                                            borderRadius: BorderRadius.all(
                                              Radius.elliptical(9999, 9999),
                                            ),
                                            border: Border.all(
                                                color: Colors.white, width: 1)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Data.size.width * .45,
                                        child: Text(
                                          'Kamal Khan',
                                          overflow: TextOverflow.ellipsis,
                                          style: Constants.applyStyle(
                                              size: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: Data.size.width * .45,
                                        child: Text(
                                          'Hello, How are you?',
                                          overflow: TextOverflow.ellipsis,
                                          style: Constants.applyStyle(
                                              size: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Just now',
                                    style: Constants.applyStyle(
                                      size: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    height: 21,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    child: Center(
                                      child: Text(
                                        '1',
                                        style: Constants.applyStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            size: 14),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 22,
                    )
                  ],
                  // height: 132,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
