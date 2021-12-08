import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OpenChat extends StatefulWidget {
  const OpenChat({Key key}) : super(key: key);

  @override
  _OpenChatState createState() => _OpenChatState();
}

class _OpenChatState extends State<OpenChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomSheet: buildBottomSheet(),
    );
  }
}

Widget buildAppBar() {
  return AppBar(
    elevation: 0,
    toolbarHeight: 80,
    titleSpacing: 0,
    title: Row(
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
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Data.size.width * .35,
              child: Text(
                'Shara Banu Banu Banu',
                style: Constants.applyStyle(
                  fontWeight: FontWeight.w600,
                  size: 18,
                  color: kAppbarTitleColor,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(232, 241, 255, 1)),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7.5),
              child: Text(
                'home cleaning',
                style: Constants.applyStyle(
                    size: 12,
                    color: Color.fromRGBO(31, 113, 237, 1),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
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
            onPressed: () {},
            svg: 'assets/icons/Calling.svg',
            color: HexColor('#1F71ED').withOpacity(0.15),
            iconColor: kPrimaryColor,
          ),
        ),
      )
    ],
  );
}

Widget buildBody() {
  return ListView.builder(
    itemCount: 3,
    padding: EdgeInsets.only(top: 20, bottom: 100),
    itemBuilder: (context, index) {
      // return Align(
      //   alignment: Alignment.centerRight,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
      //     child: Column(crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         Container(
      //             constraints: BoxConstraints(maxWidth: Data.size.width * .7),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(16).subtract(
      //                   BorderRadius.only(bottomRight: Radius.circular(16))),
      //               color: kPrimaryColor,
      //             ),
      //             padding: EdgeInsets.fromLTRB(19, 14, 12, 17),
      //             child: Text(
      //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut.',
      //               style: Constants.applyStyle(
      //                   size: 16, color: Colors.white),
      //             )),
      //         SizedBox(height: 8,),
      //         Text(
      //           '01:15 PM',
      //           style:
      //               Constants.applyStyle(size: 12, color: HexColor('#B6B6B6')),
      //         )
      //       ],
      //     ),
      //   ),
      // );
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: Data.size.width * .7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16).subtract(
                        BorderRadius.only(bottomLeft: Radius.circular(16))),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(20, 13, 17, 17),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut.',
                    style: Constants.applyStyle(
                        size: 16, color: HexColor('#263238')),
                  )),
              SizedBox(
                height: 8,
              ),
              Text(
                '01:15 PM',
                style:
                    Constants.applyStyle(size: 12, color: HexColor('#B6B6B6')),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget buildBottomSheet() {
  return Container(
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
            decoration: inputDecoration(
              hint: 'Type a Message',
              radius: BorderRadius.circular(24),
              suffixIcon: CupertinoButton(
                onPressed: () {},padding:EdgeInsets.all(5),
                minSize: 0,
                child: Icon(CupertinoIcons.mic, color: HexColor('999999'),),
              ),
              prefixIcon: CupertinoButton(
                onPressed: () {},
                padding:EdgeInsets.all(5),
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
          onPressed: () {},
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
  );
}
