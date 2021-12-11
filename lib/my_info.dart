import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import 'organizationChart.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();
  final superiorNumberController = TextEditingController();
  final organizationCodeController = TextEditingController();
  final contactController = TextEditingController();
  final introduceController = TextEditingController();
  File? _image;
  String? name;
  int? year; int? month; int? day;
  String? superiorNumber;
  String? organizationCode;
  String? contact;
  String? introduce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdfe4ee),
      body: ListView(
          children: <Widget>[Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    0,
                    MediaQuery.of(context).size.width * 0.05,
                    0.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff9bb7e7),
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.55),
                    const Text("My Info", textAlign: TextAlign.right, style: TextStyle(color: Color(0xff9bb7e7), fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.2,
                    0,
                    MediaQuery.of(context).size.width * 0.2,
                    0.0),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      const Text("이름"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            name = value;
                          }
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),

                      const Text("생년월일"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextField(
                                controller: yearController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  year = int.parse(value);
                                }
                              ),
                            ),
                            const Text(" 년 "),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextField(
                                controller: monthController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  month = int.parse(value);
                                }
                              ),
                            ),
                            const Text(" 월 "),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextField(
                                controller: dayController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  day = int.parse(value);
                                }
                              ),
                            ),
                            const Text(" 일"),
                          ]),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("상관 일련 번호"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: superiorNumberController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            superiorNumber = value;
                          }
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("기관 코드"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: organizationCodeController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            organizationCode = value;
                          }
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),

                      const Text("Contact "),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: contactController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            contact = value;
                          }
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("자기소개 "),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: introduceController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            introduce = value;
                          }
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                            child: const Text('제출하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            onPressed: () async {
                              if (name != null && year != null && month != null && day != null && superiorNumber != null && contact != null && introduce != null){
                                DocumentReference reference = await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid,);
                                await reference.set({
                                  'id': reference.id,
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  'curTime': FieldValue.serverTimestamp(),
                                  'name': name,
                                  'year': year,
                                  'month': month,
                                  'day': day,
                                  'superiorNumber': superiorNumber,
                                  'organizationCode': organizationCode,
                                  'contact': contact,
                                  'introduce': introduce,
                                  'myNumber': name!.hashCode.toString() + year!.toString() + month!.toString() + day!.toString(),
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChartPage()),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xff9bb7e7)),
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
    );
  }
  Future pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
