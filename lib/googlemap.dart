
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'locations.dart' as locations;

FirebaseFirestore fireStore = FirebaseFirestore.instance;

class FindgymPage extends StatefulWidget {

  @override
  State<FindgymPage> createState() => _FindgymPageState();
}

class _FindgymPageState extends State<FindgymPage> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();

    String? title = "";
    fireStore.collection("location").doc("amsterdam").get().then((DocumentSnapshot ds){
      title = ds.get("name");

      //print(ds.data());
    });
    fireStore.collection("location").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.get("image"));
      });
    });
    setState(() {
      _markers.clear();
      fireStore.collection("location").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          print(result.get("name"));
          print(result.get("lat"));
          print(result.get("lng"));
          print(result.get("address"));

          var a = result.get("lat") is String ? double.parse(result.get("lat")) : result.get("lat");
          var b = result.get("lng") is String ? double.parse(result.get("lng")) : result.get("lng");

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
    });
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
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(35.95, 128.25),
                      zoom: 2,
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
