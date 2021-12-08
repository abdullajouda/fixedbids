import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/text_field.dart';
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
  bool isPasswordEditing = false;
  TextEditingController oldPasswordController,
      newPasswordController,
      confirmPasswordController;
  FocusNode oldPasswordNode, newPasswordNode, confirmPasswordNode;
  bool oldPasswordObscure = true;
  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;

  @override
  void initState() {
    oldPasswordController = new TextEditingController();
    newPasswordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
    oldPasswordNode = new FocusNode();
    newPasswordNode = new FocusNode();
    confirmPasswordNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordNode.dispose();
    newPasswordNode.dispose();
    confirmPasswordNode.dispose();
    super.dispose();
  }

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
              // height: Data.size.height - appbar.preferredSize.height - 210,
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password',
                            style: Constants.applyStyle(
                                size: 18,
                                color: HexColor('#444444'),
                                fontWeight: FontWeight.w600),
                          ),
                          if (isPasswordEditing)
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
                                  isPasswordEditing = false;
                                });
                              },
                            )
                          else
                            CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Change',
                                style: Constants.applyStyle(
                                    size: 14,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordEditing = true;
                                });
                              },
                            )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (isPasswordEditing)
                        Column(
                          children: [
                            CustomTextField(
                              controller: oldPasswordController,
                              focusNode: oldPasswordNode,
                              nextFocusNode: newPasswordNode,
                              obscure: oldPasswordObscure,
                              label: 'Old password',
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              controller: newPasswordController,
                              focusNode: newPasswordNode,
                              nextFocusNode: confirmPasswordNode,
                              obscure: newPasswordObscure,
                              label: 'New password',
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              controller: confirmPasswordController,
                              focusNode: confirmPasswordNode,
                              nextFocusNode: null,
                              obscure: confirmPasswordObscure,
                              label: 'Retype password',
                            ),
                          ],
                        )
                      else
                        TextFormField(
                          initialValue: '*********',
                          style: Constants.applyStyle(
                              size: 18,
                              color: isPasswordEditing
                                  ? HexColor('444444')
                                  : HexColor('A8A8A8')),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(width: 1.0, color: kPrimaryColor),
                            ),
                            disabledBorder: InputBorder.none,
                            constraints: BoxConstraints(
                                maxHeight: isPasswordEditing ? 52 : 22),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(width: 1.0, color: kPrimaryColor),
                            ),
                          ),
                          enabled: isPasswordEditing,
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
              constraints: BoxConstraints(maxHeight: isEditing ? 52 : 22),
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
