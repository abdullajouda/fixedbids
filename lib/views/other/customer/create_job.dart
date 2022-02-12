import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixed_bids/models/job.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/jobs_controller.dart';
import 'package:fixed_bids/utils/helper.dart';
import 'package:fixed_bids/views/place_picker.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'job_published.dart';

class CreateJob extends StatefulWidget {
  final int id;
  final Job job;

  const CreateJob({Key key, this.id, this.job}) : super(key: key);

  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController,
      locationController,
      amountController,
      detailsController;
  FocusNode titleNode, amountNode, detailsNode, locationNode, urgencyNode;
  int _urgency;
  File _image;
  LatLng _location;
  bool loading = false;

  @override
  void initState() {
    if (widget.job != null) {
      _location = LatLng(double.parse(widget.job.latitude),
          double.parse(widget.job.longitude));
      _urgency = widget.job.urgencyType;
      titleController = new TextEditingController(text: widget.job.title);
      locationController = new TextEditingController(text: widget.job.zipCode);
      amountController = new TextEditingController(
          text: widget.job.price != null ? widget.job.price.toString() : '');
      detailsController = new TextEditingController(text: widget.job.details);
    } else {
      titleController = new TextEditingController();
      locationController = new TextEditingController();
      amountController = new TextEditingController();
      detailsController = new TextEditingController();
    }

    titleNode = new FocusNode();
    amountNode = new FocusNode();
    detailsNode = new FocusNode();
    locationNode = new FocusNode();
    urgencyNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    amountController.dispose();
    detailsController.dispose();
    titleNode.dispose();
    amountNode.dispose();
    detailsNode.dispose();
    locationNode.dispose();
    urgencyNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Job details'),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildContainer(
                    title: 'Photo',
                    body: CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        onPressed: () async {
                          File file =
                              await Helper().displayPickImageDialog(context);
                          if (file != null) {
                            _image = file;
                          }
                          setState(() {});
                        },
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/blue_box.svg'),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/images.svg'),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text('Upload a photo')
                                    ],
                                  )
                                ],
                              ))),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job title',
                        style: Constants.applyStyle(
                            size: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        label: 'Type here',
                        required: true,
                        controller: titleController,
                        focusNode: titleNode,
                        nextFocusNode: urgencyNode,
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Text(
                        'Urgency',
                        style: Constants.applyStyle(
                            size: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField<int>(
                        value: _urgency,
                        focusNode: urgencyNode,
                        validator: (value) {
                          if (value == null) {
                            return '* Required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _urgency = value;
                          });
                        },
                        items: Constants()
                            .urgencyOptions
                            .map(
                              (e) => DropdownMenuItem<int>(
                                value: e.id,
                                child: Text(
                                  e.title.tr(),
                                ),
                              ),
                            )
                            .toList(),
                        decoration: inputDecoration(hint: 'Select'),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Text(
                        'Location',
                        style: Constants.applyStyle(
                            size: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        label: 'Enter ZIP code',
                        required: true,
                        readOnly: true,
                        controller: locationController,
                        focusNode: locationNode,
                        nextFocusNode: amountNode,
                        onPressed: () async {
                          LatLng initialPosition =
                              await Constants.getCurrentLocation(
                                  context: context);
                          if (initialPosition != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacePickerScreen(
                                    initialPosition: initialPosition,
                                    onPlacePicked: (value) {
                                      setState(() {
                                        _location = LatLng(
                                            value.geometry.location.lat,
                                            value.geometry.location.lng);
                                        locationController.text =
                                            value.formattedAddress;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ));
                          }
                        },
                      ),
                      SizedBox(
                        height: 23,
                      ),
                    ],
                  ),
                ),
                buildContainer(
                    title: 'How much are you willing to pay?',
                    body: CustomTextField(
                        label: 'Type amount here',
                        required: true,
                        controller: amountController,
                        focusNode: amountNode,
                        nextFocusNode: detailsNode,
                        inputType: TextInputType.number,
                        prefix: Text('\$ '))),
                buildContainer(
                    title: 'Details',
                    body: CustomTextField(
                      label: 'Type details',
                      required: true,
                      controller: detailsController,
                      focusNode: detailsNode,
                      nextFocusNode: null,
                      maxLines: 5,
                    )),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          )),
      bottomSheet: Container(
        height: 100,
        width: double.infinity,
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
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Center(
          child: Button(
            title: 'Publish',
            loading: loading,
            onPressed: () async {
              if (!_formKey.currentState.validate()) {
                return;
              }
              // if (_image == null) {
              //   BotToast.showSimpleNotification(title: 'Image is Required');
              //   return;
              // }
              setState(() {
                loading = true;
              });
              ApiResponse response;
              if (widget.job != null) {
                response = await JobsController().editJob(
                  id: widget.job.id,
                  serviceId: widget.job.serviceId.toString(),
                  title: titleController.text,
                  details: detailsController.text,
                  price: amountController.text,
                  urgencyType: _urgency.toString(),
                  zipCode: locationController.text,
                  image: _image,
                  latitude: _location.latitude.toString(),
                  longitude: _location.longitude.toString(),
                );
              } else {
                response = await JobsController().addNewJob(
                  serviceId: widget.id.toString(),
                  title: titleController.text,
                  details: detailsController.text,
                  price: amountController.text,
                  urgencyType: _urgency.toString(),
                  zipCode: locationController.text,
                  image: _image,
                  latitude: _location.latitude.toString(),
                  longitude: _location.longitude.toString(),
                );
              }

              setState(() {
                loading = false;
              });
              if (response.status) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobPublished(),
                    ));
              } else {
                BotToast.showText(text: response.message);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildContainer({@required String title, Widget body}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Constants.applyStyle(size: 18, fontWeight: FontWeight.w500),
          ),
          if (body != null)
            SizedBox(
              height: 20,
            ),
          body ?? SizedBox(),
          if (body != null)
            SizedBox(
              height: 10,
            ),
        ],
      ),
    );
  }
}
