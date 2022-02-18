import 'dart:io';
import 'dart:ui';

import 'package:fixed_bids/components/messeging_component.dart';
import 'package:fixed_bids/controllers/notifications_controller.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/chat_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixed_bids/models/responses/chat_details_response.dart';
import 'package:fixed_bids/utils/helper.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
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
  FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer myPlayer = FlutterSoundPlayer();
  File _file;
  String _recording;

  startRecording() async {
    _file = null;
    if (!await Permission.microphone.status.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted)
        throw RecordingPermissionException("Microphone permission not granted");
    } else {
      await _soundRecorder.openRecorder();
      await _soundRecorder.startRecorder(
        toFile: 'audio.aac',
      );
      setState(() {});
    }
  }

  startPlayer() async {
    _file = null;
    await myPlayer.openPlayer();
    await myPlayer.startPlayer(fromURI: _recording);
    setState(() {});
  }

  @override
  void initState() {
    message = TextEditingController();
    _future = ChatController().getChatDetails(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    if (_soundRecorder != null) {
      _soundRecorder.closeRecorder();
    }
    if (myPlayer != null) {
      myPlayer.closePlayer();
      myPlayer = null;
    }
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
                            constraints:
                                BoxConstraints(maxWidth: Data.size.width * .7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16).subtract(
                                  BorderRadius.only(
                                      bottomRight: Radius.circular(16))),
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.fromLTRB(19, 14, 12, 17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (snapshot.data.messages.data[index].type ==
                                    2)
                                  ImageComponent(image: snapshot.data.messages.data[index].text,)
                                else if (snapshot
                                        .data.messages.data[index].type ==
                                    5)
                                  AudioComponent(recording: snapshot.data.messages.data[index].text,)
                                else
                                  Text(
                                    snapshot.data.messages.data[index].text,
                                    style: Constants.applyStyle(
                                        size: 16, color: Colors.white),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            timeago.format(
                                snapshot.data.messages.data[index].createdAt),
                            style: Constants.applyStyle(
                                size: 12, color: HexColor('#B6B6B6')),
                          ),
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
                            child: Column(
                              children: [
                                if (snapshot.data.messages.data[index].type ==
                                    2)
                                  ImageComponent(image: snapshot.data.messages.data[index].text,)
                                else if (snapshot
                                    .data.messages.data[index].type ==
                                    5)
                                  AudioComponent(recording: snapshot.data.messages.data[index].text,)
                                else
                                  Text(
                                    snapshot.data.messages.data[index].text,
                                    style: Constants.applyStyle(
                                        size: 16, color: HexColor('#263238')),
                                  ),
                              ],
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
            // padding: EdgeInsets.symmetric(vertical: 29),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_file != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _file = null;
                            });
                          },
                          icon: Icon(Icons.clear_rounded),
                        ),
                        Expanded(child: Text('${_file.path.split('/').last}'))
                      ],
                    ),
                  )
                else if (_recording != null)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _recording = null;
                            });
                          },
                          icon: Icon(Icons.clear_rounded),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            IconButton(
                              color: kPrimaryColor,
                              onPressed: () async {
                                if (myPlayer.isStopped) {
                                  startPlayer();
                                } else if (myPlayer.isPaused) {
                                  await myPlayer.resumePlayer();
                                } else if (myPlayer.isPlaying) {
                                  await myPlayer.stopPlayer();
                                }
                                setState(() {});
                              },
                              icon: Icon(
                                myPlayer.isStopped
                                    ? Icons.play_arrow_rounded
                                    : Icons.stop,
                              ),
                            ),
                            Text('${_recording.split('/').last}'),
                          ],
                        ))
                      ],
                    ),
                  )
                else
                  SizedBox(
                    height: 30,
                  ),
                Row(
                  children: [
                    SizedBox(
                      width: 23,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: message,
                        onFieldSubmitted: (value) async {
                          setState(() {
                            if (_file != null) {
                              snapshot.data.messages.data.insert(
                                0,
                                Message(
                                  text: _file.path,
                                  type: 2,
                                  senderId: Data.currentUser.id,
                                  createdAt: DateTime.now(),
                                ),
                              );
                              ChatController().sendAttachmentMessage(
                                  id: widget.id,
                                  type: 2,
                                  user: snapshot.data.user.id,
                                  attachment: _file,
                                  text: message.text);
                              setState(() {
                                _file = null;
                                message.clear();
                              });
                            } else if (_recording != null) {
                              snapshot.data.messages.data.insert(
                                0,
                                Message(
                                  text: _recording,
                                  type: 5,
                                  senderId: Data.currentUser.id,
                                  createdAt: DateTime.now(),
                                ),
                              );
                              ChatController().sendAttachmentMessage(
                                  id: widget.id,
                                  type: 5,
                                  user: snapshot.data.user.id,
                                  attachment: File(_recording),
                                  text: message.text);
                              setState(() {
                                _recording = null;
                                message.clear();
                              });
                            } else {
                              snapshot.data.messages.data.insert(
                                  0,
                                  Message(
                                      text: message.text,
                                      senderId: Data.currentUser.id,
                                      createdAt: DateTime.now()));
                              ChatController().sendTextMessage(
                                  id: widget.id,
                                  user: snapshot.data.user.id,
                                  text: message.text);
                              setState(() {
                                message.clear();
                              });
                            }
                          });
                        },
                        decoration: inputDecoration(
                          hint: 'Type a Message'.tr(),
                          radius: BorderRadius.circular(24),
                          suffixIcon: CupertinoButton(
                            onPressed: () async {
                              if (_soundRecorder.isStopped) {
                                startRecording();
                              } else if (_soundRecorder.isPaused) {
                                await _soundRecorder.resumeRecorder();
                              } else if (_soundRecorder.isRecording) {
                                _recording =
                                    await _soundRecorder.stopRecorder();
                                print(_recording);
                              }
                              setState(() {});
                            },
                            padding: EdgeInsets.all(5),
                            minSize: 0,
                            child: Icon(
                              CupertinoIcons.mic,
                              color: _soundRecorder.isRecording
                                  ? Colors.red[700]
                                  : HexColor('999999'),
                            ),
                          ),
                          prefixIcon: CupertinoButton(
                            onPressed: () async {
                              _file = await Helper()
                                  .displayPickImageDialog(context);
                              setState(() {});
                            },
                            padding: EdgeInsets.all(5),
                            minSize: 0,
                            child:
                                SvgPicture.asset('assets/icons/attachment.svg'),
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
                          if (_file != null) {
                            snapshot.data.messages.data.insert(
                              0,
                              Message(
                                text: _file.path,
                                type: 2,
                                senderId: Data.currentUser.id,
                                createdAt: DateTime.now(),
                              ),
                            );
                            ChatController().sendAttachmentMessage(
                                id: widget.id,
                                type: 2,
                                user: snapshot.data.user.id,
                                attachment: _file,
                                text: message.text);
                            setState(() {
                              _file = null;
                              message.clear();
                            });
                          } else if (_recording != null) {
                            snapshot.data.messages.data.insert(
                              0,
                              Message(
                                text: _recording,
                                type: 5,
                                senderId: Data.currentUser.id,
                                createdAt: DateTime.now(),
                              ),
                            );
                            ChatController().sendAttachmentMessage(
                                id: widget.id,
                                type: 5,
                                user: snapshot.data.user.id,
                                attachment: File(_recording),
                                text: message.text);
                            setState(() {
                              _recording = null;
                              message.clear();
                            });
                          } else {
                            snapshot.data.messages.data.insert(
                                0,
                                Message(
                                    text: message.text,
                                    senderId: Data.currentUser.id,
                                    createdAt: DateTime.now()));
                            ChatController().sendTextMessage(
                                id: widget.id,
                                user: snapshot.data.user.id,
                                text: message.text);
                            setState(() {
                              message.clear();
                            });
                          }
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
                SizedBox(
                  height: 30,
                )
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
              if (value.onlineUsers.contains('${data.user.id}')) {
                return Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: purpleColor,
                    image: DecorationImage(
                        image: NetworkImage(data.user.imageProfile),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(9999, 9999),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 3),
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
                          border: Border.all(color: Colors.white, width: 1)),
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
                borderRadius: BorderRadius.all(
                  Radius.elliptical(9999, 9999),
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
