import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/user_controller.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class EnterZipCode extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String zipCode;

  const EnterZipCode({Key key, this.latitude, this.longitude, this.zipCode})
      : super(key: key);

  @override
  _EnterZipCodeState createState() => _EnterZipCodeState();
}

class _EnterZipCodeState extends State<EnterZipCode> {
  // TextEditingController search = TextEditingController();
  TextEditingController zipCode;

  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor bitmapDescriptor;
  List<Marker> markers = [];
  LatLng _location;
  bool load = false;

  Future loadDescriptors() async {
    bitmapDescriptor =
        await bitmapDescriptorFromSvgAsset(context, 'assets/icons/map_pin.svg');
  }

  Future<LatLng> getLocationFromZipCode() async {
    // var addresses =
    //     await Geocoder.google('AIzaSyCYf4b7gvOivFUwidxSzSPhPcpQz0WJ7gg')
    //         .findAddressesFromQuery(zipCode.text);
    List<Location> locations = await locationFromAddress(zipCode.text);
    if (locations.isNotEmpty) {
      print(locations.first.latitude);
      LatLng latLng =
          LatLng(locations.first.latitude, locations.first.longitude);
      var ct = await _controller.future;
      ct.animateCamera(CameraUpdate.newLatLng(latLng));
      _location = latLng;
      markers.clear();
      markers.add(
        Marker(markerId: MarkerId('id'), position: latLng),
      );
      setState(() {});
      return latLng;
    }
    return null;
  }

  @override
  void initState() {
    if (widget.zipCode != null) {
      _location = LatLng(widget.latitude, widget.longitude);
      markers.add(
        Marker(markerId: MarkerId('id'), position: _location),
      );
      zipCode = TextEditingController(text: widget.zipCode);
    } else {
      zipCode = TextEditingController();
    }
    loadDescriptors();
    super.initState();
  }

  @override
  void dispose() {
    // search.dispose();
    zipCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    widget.latitude ?? 37.0902, widget.longitude ?? 95.7129),
                zoom: 6.4746,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: markers.toSet(),
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0c000000),
                      blurRadius: 6,
                      offset: Offset(0, -5),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Set your location first".tr(),
                      style: TextStyle(
                        color: Color(0xff3e3e3e),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: zipCode,
                      onChanged: (value) async {
                        await getLocationFromZipCode();
                        setState(() {});
                      },
                      onFieldSubmitted: (value) async =>
                          await getLocationFromZipCode(),
                      validator: (value) =>
                          FieldValidator.validate(value, context),
                      decoration: inputDecoration(hint: 'Enter ZIP code'.tr()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Button(
                      title: 'Save'.tr(),
                      loading: load,
                      onPressed: _location == null
                          ? null
                          : () async {
                              setState(() {
                                load = true;
                              });
                              var response = await UserController()
                                  .updateLocation(
                                      zipCode: zipCode.text,
                                      lat: _location.latitude.toString(),
                                      lng: _location.longitude.toString());
                              if (response.status && widget.zipCode == null) {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RootPage(),
                                    ));
                              } else if (response.status &&
                                  widget.zipCode != null) {
                                Data.currentUser.zipCode = zipCode.text;
                                Data.currentUser.latitude =
                                    _location.latitude.toString();
                                Data.currentUser.longitude =
                                    _location.longitude.toString();
                                Navigator.of(context).pop(true);
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => RootPage(
                                //         index: 3,
                                //       ),
                                //     ));
                              }
                              setState(() {
                                load = false;
                              });
                            },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
