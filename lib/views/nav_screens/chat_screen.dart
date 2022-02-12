import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/chat_controller.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/chat_list_response.dart';
import 'package:fixed_bids/views/other/open_chat.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future _future;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      _future = ChatController().getChatList();
    });
  }

  @override
  void initState() {
    _future = ChatController().getChatList();
    super.initState();
  }

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
                onFieldSubmitted: (value) {
                  setState(() {
                    _future = ChatController().getChatList(search: value);
                  });
                },
                decoration:
                    searchInputDecoration(hint: 'Search user or message'),
              )),
        ),
        SizedBox(
          height: 5,
        ),
        FutureBuilder<ChatListResponse>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(child: Loading());
            }
            return Expanded(
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
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: snapshot.data.chats.data.length,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                      itemBuilder: (context, index) => Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OpenChat(
                                          id: snapshot.data.chats.data[index].id),
                                    ));
                              },
                              splashColor: kPrimaryColor,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 22),
                                child: Row(
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
                                            alignment:
                                                AlignmentDirectional.bottomEnd,
                                            child: Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: HexColor('#27C837'),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.elliptical(9999, 9999),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1)),
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
                                                snapshot.data.chats.data[index]
                                                    .user.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: Constants.applyStyle(
                                                    color: snapshot
                                                                .data
                                                                .chats
                                                                .data[index]
                                                                .lastMessage
                                                                .seen >
                                                            0
                                                        ? Color(0xff263238)
                                                        : Color(0xff717171),
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
                                                snapshot.data.chats.data[index]
                                                    .lastMessage.text,
                                                overflow: TextOverflow.ellipsis,
                                                style: Constants.applyStyle(
                                                    color: snapshot
                                                                .data
                                                                .chats
                                                                .data[index]
                                                                .lastMessage
                                                                .seen >
                                                            0
                                                        ? Color(0xff263238)
                                                        : Color(0xffA8A8A8),
                                                    size: 14,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            timeago.format(snapshot.data.chats
                                                .data[index].createdAt),
                                            style: Constants.applyStyle(
                                              color: snapshot
                                                  .data
                                                  .chats
                                                  .data[index]
                                                  .lastMessage
                                                  .seen >
                                                  0
                                                  ? Color(0xff263238)
                                                  : Color(0xffB6B6B6),
                                              size: 12,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                          SizedBox(
                                            height: 9,
                                          ),
                                          if (snapshot.data.chats.data[index]
                                                  .lastMessage.seen >
                                              0)
                                            Container(
                                              height: 21,
                                              width: 21,
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 7),
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
                                      ),
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
            );
          },
        ),
      ],
    );
  }
}
