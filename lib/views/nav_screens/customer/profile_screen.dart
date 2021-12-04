import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNameEditing = false;
  bool isEmailEditing = false;
  bool isLocationEditing = false;

  @override
  Widget build(BuildContext context) {
    AppBar appbar = buildAppBar(
      color: Colors.transparent,
      leading: MyIconButton(
        onPressed: () {},
        svg: 'assets/icons/logout.svg',
        iconColor: HexColor('FF0000'),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 22)
            .add(EdgeInsets.only(top: appbar.preferredSize.height, bottom: 30)),
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 145,
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
                            'Manua Vatar',
                            style: Constants.applyStyle(
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Los Angeles, CA 90001',
                            style: Constants.applyStyle(
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextLightColor),
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
                                          'assets/icons/camera.svg')))),
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
              height: Data.size.height - appbar.preferredSize.height - 210,
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
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 25),
              child: Column(
                children: [
                  buildInfoField(
                    title: 'Name',
                    buttonTitle: 'Edit',
                    isEditing: isNameEditing,
                    initialValue: 'Mukhtar Ahmad',
                  ),
                  buildInfoField(
                    title: 'Email',
                    buttonTitle: 'Edit',
                    isEditing: isEmailEditing,
                    initialValue: 'mahabub.j@gmail.com',
                  ),
                  buildInfoField(
                    title: 'Password',
                    buttonTitle: 'Change',
                    initialValue: '*********',
                  ),
                  buildInfoField(
                    title: 'Location',
                    buttonTitle: 'Edit',
                    isEditing: isLocationEditing,
                    initialValue: 'Los Angeles, CA 90001',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInfoField(
      {@required String title,
      @required String buttonTitle,
      bool isEditing = false,
      String initialValue = ''}) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Constants.applyStyle(
                    size: 18,
                    color: HexColor('#444444'),
                    fontWeight: FontWeight.w600),
              ),
              if (isEditing)
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Save',
                    style: Constants.applyStyle(
                        size: 14,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = false;
                    });
                  },
                )
              else
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    buttonTitle,
                    style: Constants.applyStyle(
                        size: 14,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            initialValue: initialValue,
            style: Constants.applyStyle(
                size: 18,
                color: isEditing ? HexColor('444444') : HexColor('A8A8A8')),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(width: 1.0, color: kPrimaryColor),
              ),
              disabledBorder: InputBorder.none,
              constraints: BoxConstraints(maxHeight:isEditing? 52:22),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(width: 1.0, color: kPrimaryColor),
              ),
            ),
            enabled: isEditing,
          ),
          SizedBox(
            height: 20,
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
      ),
    );
  }
}
