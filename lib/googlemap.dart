
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'locations.dart' as locations;
import 'organizationchart.dart';
import 'package:http/http.dart' as http;

String orgaDes = "";
String orgaName = "";
String address = "";
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
      print("orcode");
      print(orCode);
       await fireStore.collection("company").where('organizationCode', isEqualTo: orCode).get().then((querySnapshot) async {
         for(var result in querySnapshot.docs) {
           orgaDes = result.get('organizationIntro');
           orgaName = result.get('organizationName');
           address = result.get('organizationAddress');
           address.replaceAll(" ", "+");
         }
         final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyBWe2R-gsETR-bTh5NQ3JLVj_xILiYOasE'));
         a = jsonDecode(response.body)['results'][0]['geometry']['location']['lat'];
         b = jsonDecode(response.body)['results'][0]['geometry']['location']['lng'];


         final marker = Marker(
           markerId: MarkerId(orgaName),
           position: LatLng(a, b),
           infoWindow: InfoWindow(
             title: orgaName,
             snippet: orgaDes,
           ),
         );
         _markers[orgaName] = marker;
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
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: FutureBuilder(
                      future: makeMarker(),
                      builder: (BuildContext context,
                          AsyncSnapshot snapshot) {
                        if (_markers.isEmpty) {
                          return CircularProgressIndicator();
                        }else{
                        return GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition:  CameraPosition(
                          target: LatLng(a, b),
                          zoom: 10,
                        ),
                        markers: _markers.values.toSet(),
                      );}
                    }
                  ),
                ),
              ),
            ],
          ),]
      ),
    );
  }
}

