import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/controllers/provider_controller.dart';
import 'package:fixed_bids/controllers/user_controller.dart';
import 'package:fixed_bids/external/lib/src/place_picker.dart';
import 'package:fixed_bids/models/responses/login_response.dart';
import 'package:fixed_bids/views/auth/sign_in.dart';
import 'package:fixed_bids/views/other/settings.dart';
import 'package:fixed_bids/views/place_picker.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/icon_button.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContractorProfileEdit extends StatefulWidget {
  const ContractorProfileEdit({Key key}) : super(key: key);

  @override
  _ContractorProfileEditState createState() => _ContractorProfileEditState();
}

class _ContractorProfileEditState extends State<ContractorProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isNameLoading = false;
  bool isEmailLoading = false;
  bool isLocationLoading = false;
  bool isPasswordLoading = false;
  bool isPasswordEditing = false;
  TextEditingController nameController, emailController, locationController;
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
    nameController = new TextEditingController(text: Data.currentUser.name);
    emailController = new TextEditingController(text: Data.currentUser.email);
    locationController =
        new TextEditingController(text: Data.currentUser.address);
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
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    oldPasswordNode.dispose();
    newPasswordNode.dispose();
    confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = buildAppBar(
      color: Colors.transparent,
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
              height: 275,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 230,
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
                            Data.currentUser.name,
                            style: Constants.applyStyle(
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            Data.currentUser.address??'',
                            style: Constants.applyStyle(
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextLightColor),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${Data.currentUser.completeJobCount}',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Job Done',
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
                                    '${Data.currentUser.rate}',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Avg. Ratings',
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
                                    '\$29',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'St. Rate',
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
                        image: DecorationImage(
                            image: NetworkImage(
                              Data.currentUser.imageProfile,
                            ),
                            fit: BoxFit.cover),
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
                                child:
                                    SvgPicture.asset('assets/icons/camera.svg'),
                              ),
                            ),
                          ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    BuildInfoField(
                      title: 'Name',
                      buttonTitle: 'Edit',
                      controller: nameController,
                      loading: isNameLoading,
                      function: () async {
                        setState(() {
                          isNameLoading = true;
                        });
                        await UserController().editProfile(
                            name: nameController.text,
                            email: emailController.text,
                            address: locationController.text,
                            latitude: Data.currentUser.latitude,
                            longitude: Data.currentUser.longitude);
                        setState(() {
                          isNameLoading = false;
                        });
                      },
                    ),
                    BuildInfoField(
                      title: 'Email',
                      buttonTitle: 'Edit',
                      controller: emailController,
                      loading: isEmailLoading,
                      function: () async {
                        setState(() {
                          isEmailLoading = true;
                        });
                        await UserController().editProfile(
                            name: nameController.text,
                            email: emailController.text,
                            address: locationController.text,
                            latitude: Data.currentUser.latitude,
                            longitude: Data.currentUser.longitude);
                        setState(() {
                          isEmailLoading = false;
                        });
                      },
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
                            if (isPasswordLoading)
                              CircleAvatar(child: ButtonLoad())
                            else if (isPasswordEditing)
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
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isPasswordLoading = true;
                                    });
                                    LoginResponse response =
                                        await UserController().editProfile(
                                            name: nameController.text,
                                            email: emailController.text,
                                            address: locationController.text,
                                            latitude: Data.currentUser.latitude,
                                            longitude:
                                                Data.currentUser.longitude,
                                            oldPassword:
                                                oldPasswordController.text,
                                            password:
                                                newPasswordController.text,
                                            confirmPassword:
                                                confirmPasswordController.text);
                                    setState(() {
                                      isPasswordLoading = false;
                                    });
                                    if (response.status) {
                                      setState(() {
                                        isPasswordEditing = false;
                                        oldPasswordController.clear();
                                        newPasswordController.clear();
                                        confirmPasswordController.clear();
                                      });
                                    }
                                  }
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
                                borderSide: BorderSide(
                                    width: 1.0, color: kPrimaryColor),
                              ),
                              disabledBorder: InputBorder.none,
                              constraints: BoxConstraints(
                                  maxHeight: isPasswordEditing ? 52 : 22),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    width: 1.0, color: kPrimaryColor),
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
                    BuildInfoField(
                      title: 'Location',
                      buttonTitle: 'Edit',
                      readOnly: true,
                      controller: locationController,
                      loading: isLocationLoading,
                      onTextFieldPress: () async {
                        LatLng initialPosition =
                            await Constants.getCurrentLocation(
                                context: context);
                        if (initialPosition != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePickerScreen(
                                  initialPosition: initialPosition,
                                  onPlacePicked: (p0) {
                                    Navigator.pop(context);
                                    setState(() {
                                      Data.currentUser.latitude =
                                          p0.geometry.location.lat.toString();
                                      Data.currentUser.longitude =
                                          p0.geometry.location.lng.toString();
                                      locationController.text =
                                          p0.formattedAddress;
                                    });
                                  },
                                ),
                              ));
                        }
                      },
                      function: () async {
                        setState(() {
                          isLocationLoading = true;
                        });
                        await ProviderController().editProfile(
                            name: nameController.text,
                            email: emailController.text,
                            address: locationController.text,
                            latitude: Data.currentUser.latitude,
                            longitude: Data.currentUser.longitude);
                        setState(() {
                          isLocationLoading = false;
                        });
                      },
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        GlobalController().logout();
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logout.svg',
                            color: HexColor('FF0000'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Log out',
                            style: TextStyle(color: HexColor('FF0000')),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildInfoField extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final bool loading;
  final bool readOnly;
  final TextEditingController controller;
  final VoidCallback function;
  final VoidCallback onTextFieldPress;

  const BuildInfoField(
      {Key key,
      this.title,
      this.buttonTitle,
      this.controller,
      this.loading = false,
      this.function,
      this.readOnly = false,
      this.onTextFieldPress})
      : super(key: key);

  @override
  State<BuildInfoField> createState() => _BuildInfoFieldState();
}

class _BuildInfoFieldState extends State<BuildInfoField> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: Constants.applyStyle(
                  size: 18,
                  color: HexColor('#444444'),
                  fontWeight: FontWeight.w600),
            ),
            if (widget.loading)
              CircleAvatar(child: ButtonLoad())
            else if (isEditing)
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
                onPressed: () async {
                  widget.function.call();
                  setState(() {
                    isEditing = false;
                  });
                },
              )
            else if (!isEditing || !widget.loading)
              CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  widget.buttonTitle,
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
          controller: widget.controller,
          readOnly: widget.readOnly,
          onTap: widget.onTextFieldPress,
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
    );
  }
}
