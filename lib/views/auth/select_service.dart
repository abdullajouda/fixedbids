import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/provider_controller.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/auth/sign_in.dart';
import 'package:fixed_bids/views/other/enter_zip_code.dart';
import 'package:fixed_bids/widgets/back_button.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/check_box.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../place_picker.dart';

class SelectService extends StatefulWidget {
  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  List<int> _services = [];
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                  padding: const EdgeInsets.all(22.0), child: MyBackButton()),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Select your skills'.tr(),
                      style: TextStyle(
                        fontSize: 24,
                        color: kTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'What services do you want to provide?'.tr(),
                      style: TextStyle(
                        fontSize: 17,
                        color: kTextLightColor,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: Data.size.height * .06,
                    ),
                    ListView.builder(
                      itemCount: Data.services.items.length,
                      padding: kPadding,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _checkBoxBuilder(
                        title: Data.services.items[index].name,
                        value:
                            _services.contains(Data.services.items[index].id),
                        onPressed: () {
                          setState(() {
                            if (_services
                                .contains(Data.services.items[index].id)) {
                              _services.remove(Data.services.items[index].id);
                            } else {
                              _services.add(Data.services.items[index].id);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: Data.size.height * .1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: kPadding.add(EdgeInsets.only(bottom: 30)),
          child: SizedBox(
            height: 55,
            child: Button(
              title: 'Next'.tr(),
              loading: load,
              onPressed: () async {
                setState(() {
                  load = true;
                });
                ApiResponse response = await ProviderController()
                    .editServices(services: _services);
                if (response.status) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EnterZipCode()));
                } else {
                  BotToast.showText(text: response.message);
                }
                setState(() {
                  load = false;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkBoxBuilder({String title, VoidCallback onPressed, bool value}) {
    return Column(
      children: [
        TextButton(
            onPressed: onPressed,
            child: Row(
              children: [
                CustomCheckBox(
                  value: value,
                  onPressed: onPressed,
                ),
                Text(
                  '$title',
                  style: Constants.applyStyle(
                      size: 18,
                      color: Color(0x0ff655D64),
                      fontWeight: FontWeight.w400),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: Color(0x0ffE3E3E3),
            thickness: 1,
            height: 0,
          ),
        )
      ],
    );
  }
}
