import 'package:fixed_bids/controllers/notifications_controller.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/chat_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixed_bids/models/responses/chat_details_response.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class OpenChat extends StatefulWidget {
  final int id;

  const OpenChat({Key key, this.id}) : super(key: key);

  @override
  _OpenChatState createState() => _OpenChatState();
}

class _OpenChatState extends State<OpenChat> {
  Future _future;
  TextEditingController message;

  @override
  void initState() {
    message = TextEditingController();
    _future = ChatController().getChatDetails(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChatDetailsResponse>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(child: Loading());
        }
        return Scaffold(
          appBar: buildAppBar(data: snapshot.data),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, bottom: 100),
            reverse: true,
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.messages.data.length,
              itemBuilder: (context, index) {
                if (snapshot.data.messages.data[index].senderId ==
                    Data.currentUser.id) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  maxWidth: Data.size.width * .7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)
                                    .subtract(BorderRadius.only(
                                        bottomRight: Radius.circular(16))),
                                color: kPrimaryColor,
                              ),
                              padding: EdgeInsets.fromLTRB(19, 14, 12, 17),
                              child: Text(
                                snapshot.data.messages.data[index].text,
                                style: Constants.applyStyle(
                                    size: 16, color: Colors.white),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            timeago.format(
                                snapshot.data.messages.data[index].createdAt),
                            style: Constants.applyStyle(
                                size: 12, color: HexColor('#B6B6B6')),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            constraints:
                                BoxConstraints(maxWidth: Data.size.width * .7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16).subtract(
                                  BorderRadius.only(
                                      bottomLeft: Radius.circular(16))),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.fromLTRB(20, 13, 17, 17),
                            child: Text(
                              snapshot.data.messages.data[index].text,
                              style: Constants.applyStyle(
                                  size: 16, color: HexColor('#263238')),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          timeago.format(
                              snapshot.data.messages.data[index].createdAt),
                          style: Constants.applyStyle(
                              size: 12, color: HexColor('#B6B6B6')),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomSheet: Container(
            // height: 108,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.symmetric(vertical: 29),
            child: Row(
              children: [
                SizedBox(
                  width: 23,
                ),
                Expanded(
                  child: TextFormField(
                    controller: message,
                    onFieldSubmitted: (value) async {
                      setState(() {
                        snapshot.data.messages.data.insert(
                            0,
                            Message(
                                text: message.text,
                                senderId: Data.currentUser.id,
                                createdAt: DateTime.now()));
                      });

                      ChatController().sendTextMessage(
                          id: widget.id,
                          user: snapshot.data.user.id,
                          text: message.text);
                      setState(() {
                        message.clear();
                      });
                    },
                    decoration: inputDecoration(
                      hint: 'Type a Message'.tr(),
                      radius: BorderRadius.circular(24),
                      suffixIcon: CupertinoButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(5),
                        minSize: 0,
                        child: Icon(
                          CupertinoIcons.mic,
                          color: HexColor('999999'),
                        ),
                      ),
                      prefixIcon: CupertinoButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(5),
                        minSize: 0,
                        child: SvgPicture.asset('assets/icons/attachment.svg'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MyIconButton(
                  onPressed: () async {
                    setState(() {
                      snapshot.data.messages.data.insert(
                          0,
                          Message(
                              text: message.text,
                              senderId: Data.currentUser.id,
                              createdAt: DateTime.now()));
                    });
                    ChatController().sendTextMessage(
                        id: widget.id,
                        user: snapshot.data.user.id,
                        text: message.text);
                    setState(() {
                      message.clear();
                    });
                  },
                  isRounded: true,
                  color: kPrimaryColor,
                  svg: 'assets/icons/Send.svg',
                  iconColor: Colors.white,
                ),
                SizedBox(
                  width: 13,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAppBar({ChatDetailsResponse data}) {
    if (data == null) {
      return AppBar(
        elevation: 0,
        toolbarHeight: 80,
        titleSpacing: 0,
        backgroundColor: Color(0x0ffF8F8F8),
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Center(child: MyBackButton()),
        ),
      );
    }
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      titleSpacing: 0,
      title: Row(
        children: [
          Consumer<NotificationsController>(
            builder: (_, value, child) {
              if (value.onlineUsers.contains(
                  '${data.user.id}')) {
                return Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: purpleColor,
                    image: DecorationImage(
                        image: NetworkImage(data.user.imageProfile),
                        fit: BoxFit.cover),
                    borderRadius:
                    BorderRadius.all(
                      Radius.elliptical(
                          9999, 9999),
                    ),
                  ),
                  padding:
                  EdgeInsets.symmetric(
                      horizontal: 3),
                  child: Align(
                    alignment:
                    AlignmentDirectional
                        .bottomEnd,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration:
                      BoxDecoration(
                          color: HexColor(
                              '#27C837'),
                          borderRadius:
                          BorderRadius
                              .all(
                            Radius.elliptical(
                                9999,
                                9999),
                          ),
                          border: Border.all(
                              color: Colors
                                  .white,
                              width:
                              1)),
                    ),
                  ),
                );
              }
              return child;
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: purpleColor,
                image: DecorationImage(
                    image: NetworkImage(data.user.imageProfile),
                    fit: BoxFit.cover),
                borderRadius:
                BorderRadius.all(
                  Radius.elliptical(
                      9999, 9999),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.user.name,
                  style: Constants.applyStyle(
                    fontWeight: FontWeight.w600,
                    size: 18,
                    color: kAppbarTitleColor,
                  ),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: Color.fromRGBO(232, 241, 255, 1)),
                //   padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7.5),
                //   child: Text(
                //     'home cleaning',
                //     style: Constants.applyStyle(
                //         size: 12,
                //         color: Color.fromRGBO(31, 113, 237, 1),
                //         fontWeight: FontWeight.w400),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0x0ffF8F8F8),
      leadingWidth: 90,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Center(child: MyBackButton()),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Center(
            child: MyIconButton(
              onPressed: () async {
                await launch('tel:' + data.user.mobile);
              },
              svg: 'assets/icons/Calling.svg',
              color: HexColor('#1F71ED').withOpacity(0.15),
              iconColor: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
