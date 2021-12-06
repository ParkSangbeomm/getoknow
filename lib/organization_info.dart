import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'organizationchart.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final organizationNameController = TextEditingController();
  final organizationIntroduceController = TextEditingController();
  final organizationCodeEditController = TextEditingController();
  final organizationAddressController = TextEditingController();

  String? organizationName;
  String? organizationIntro;
  String? organizationCode;
  String? organizationAddress;

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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.18),
                    const Text("Create Organization", textAlign: TextAlign.right, style: TextStyle(color: Color(0xff9bb7e7), fontSize: 25, fontWeight: FontWeight.bold)),
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
                      const Text("기관 이름"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: organizationNameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            organizationName = value;
                          }
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("기관 소개"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: organizationIntroduceController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            organizationIntro = value;
                          }
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("기관 코드 설정"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: organizationCodeEditController,
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
                      const Text("주소 지번"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                            controller: organizationAddressController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              isDense: true,
                            ),
                            onChanged: (value) {
                              organizationAddress = value;
                            }
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                            child: const Text('제출하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            onPressed: () async {
                              if (organizationName != null && organizationIntro != null && organizationCode != null){
                                DocumentReference reference = await FirebaseFirestore.instance
                                    .collection('company')
                                    .doc();
                                await reference.set({
                                  'id': reference.id,
                                  'curTime': FieldValue.serverTimestamp(),
                                  'organizationName': organizationName,
                                  'organizationIntro': organizationIntro,
                                  'organizationCode': organizationCode,
                                  'organizationAddress' : organizationAddress,
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SecondPage()),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xff9bb7e7)),
                            )
                        ),
                      ),
                      SizedBox(
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
}
