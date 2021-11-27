import 'package:fixed_bids/external/lib/src/models/pick_result.dart';
import 'package:fixed_bids/external/lib/src/place_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePickerScreen extends StatefulWidget {
  final Function(PickResult) onPlacePicked;
  final LatLng initialPosition;
  final double zoom;
  final bool selectInitialPosition;

  PlacePickerScreen({
    @required this.onPlacePicked,
    @required this.initialPosition,
    this.zoom,
    this.selectInitialPosition = false,
  });

  @override
  _PlacePickerScreenState createState() => _PlacePickerScreenState();
}

class _PlacePickerScreenState extends State<PlacePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PlacePicker(
        apiKey: "AIzaSyCYf4b7gvOivFUwidxSzSPhPcpQz0WJ7gg",
        zoom: widget.zoom,
        myLocationButtonCooldown: 1,
        selectInitialPosition: widget.selectInitialPosition,
        useCurrentLocation: false,
        initialPosition: widget.initialPosition,
        automaticallyImplyAppBarLeading: false,
        selectedPlaceWidgetBuilder: (BuildContext context,
                PickResult selectedPlace,
                SearchingState state,
                bool isSearchBarFocused) =>
            Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: state == SearchingState.Searching
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedPlace.name ??
                                  selectedPlace.formattedAddress ??
                                  'UnnamedPlace',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              widget.onPlacePicked(selectedPlace);
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(Icons.check),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
