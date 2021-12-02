
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'locations.dart' as locations;

final Map<String, Marker> _markers = {};
FirebaseFirestore fireStore = FirebaseFirestore.instance;
 double a = 0;
 double b = 0;
class FindgymPage extends StatefulWidget {

  @override
  State<FindgymPage> createState() => _FindgymPageState();
}

class _FindgymPageState extends State<FindgymPage> {

  Future<void> _onMapCreated(GoogleMapController controller) async {
    //final googleOffices = await locations.getGoogleOffices();
    await makeMarker();
  }
  Future<void> makeMarker() async{
      _markers.clear();
       await fireStore.collection("location").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {

          a = result.get("lat") is String ? double.parse(result.get("lat")) : result.get("lat");
          b = result.get("lng") is String ? double.parse(result.get("lng")) : result.get("lng");
          //print(a.runtimeType);
          final marker = Marker(
            markerId: MarkerId(result.get("name")),
            position: LatLng(a, b),
            infoWindow: InfoWindow(
              title: result.get("name"),
              snippet: result.get("address"),
            ),
          );
          _markers[result.get("name")] = marker;
        }});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: <Widget>[Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.05,
                    0.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffe49191),
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '지역, 지하철쳑, 센터 검색',
                          )
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    0.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition:  CameraPosition(
                      target: LatLng(a, b),
                      zoom: 5,
                    ),
                    markers: _markers.values.toSet(),
                  ),
                ),
              ),
            ],
          ),]
      ),
    );
  }
}

