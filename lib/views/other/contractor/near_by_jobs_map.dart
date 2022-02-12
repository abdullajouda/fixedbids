import 'dart:async';
import 'dart:io';

import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/controllers/provider_controller.dart';
import 'package:fixed_bids/models/job.dart';
import 'package:fixed_bids/models/responses/nearby_jobs_response.dart';
import 'package:fixed_bids/models/responses/nearby_jobs_response.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyJobsMap extends StatefulWidget {
  final LatLng initialPosition;

  NearbyJobsMap({
    @required this.initialPosition,
  });

  @override
  _NearbyJobsMapState createState() => _NearbyJobsMapState();
}

class _NearbyJobsMapState extends State<NearbyJobsMap> {
  TextEditingController search = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor bitmapDescriptor;
  List<Marker> markers = [];
  NearByJobsResponse _jobsResponse;

  Future loadDescriptors() async {
    bitmapDescriptor =
        await bitmapDescriptorFromSvgAsset(context, 'assets/icons/map_pin.svg');
  }

 

  nearByJobs() async {
    _jobsResponse = await ProviderController().nearbyJobs(
        lng: 32.6,
        lat: 22.33,
        search: search.text);
    _jobsResponse.items.forEach((element) {
      markers.add(
        Marker(
          position: LatLng(double.parse(element.latitude),double.parse(element.longitude)),
          markerId: MarkerId(element.id.toString()),
          icon: bitmapDescriptor,
        ),
      );
    });
  }

  @override
  void initState() {
    loadDescriptors().then((value) => nearByJobs());
     super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0.0,
        toolbarHeight: 50,
        title: Row(
          children: <Widget>[
            IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                ),
                padding: EdgeInsets.zero),
            Expanded(
              child: TextFormField(
                controller: search,
                decoration: searchInputDecoration(hint: 'Search'),
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.initialPosition,
            zoom: 18.4746,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: markers.toSet(),
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
