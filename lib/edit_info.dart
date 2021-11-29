import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'organizationChart.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();
  final superiorNameController = TextEditingController();
  final superiorNumberController = TextEditingController();
  final contactController = TextEditingController();
  final introduceController = TextEditingController();
  String? name;
  int? year; int? month; int? day;
  String? superiorName;
  String? superiorNumber;
  String? contact;
  String? introduce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdfe4ee),
      body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          name = snapshot.data!.docs[0].get('name');
          year = snapshot.data!.docs[0].get('year');
          month = snapshot.data!.docs[0].get('month');
          day = snapshot.data!.docs[0].get('day');
          superiorNumber = snapshot.data!.docs[0].get('superiorNumber');
          contact = snapshot.data!.docs[0].get('contact');
          introduce = snapshot.data!.docs[0].get('introduce');
          return ListView(
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
                        SizedBox(width: MediaQuery.of(context).size.width * 0.45),
                        const Text("Edit myInfo", textAlign: TextAlign.right, style: TextStyle(color: Color(0xff9bb7e7), fontSize: 25, fontWeight: FontWeight.bold)),
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
                          const Text('개인 일련번호 (복사 기능)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 3),
                          const Text('1029108397424'),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                          const Center(
                            child: Text("내 정보 수정", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          const Center(
                            child: CircleAvatar(
                              radius: 80,
                              //backgroundImage: AssetImage('img/profile.png'),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              child: const Text("사진 변경", style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline,)),
                              onPressed: () {  },
                            ),
                          ),
                          const Text("이름"),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              initialValue: snapshot.data!.docs[0].get('name'),
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
                                  child: TextFormField(
                                    initialValue: snapshot.data!.docs[0].get('year').toString(),
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
                                  child: TextFormField(
                                    initialValue: snapshot.data!.docs[0].get('month').toString(),
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
                                  child: TextFormField(
                                    initialValue: snapshot.data!.docs[0].get('day').toString(),
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
                            child: TextFormField(
                              initialValue: snapshot.data!.docs[0].get('superiorNumber'),
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
                          const Text("Contact (선택)"),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              initialValue: snapshot.data!.docs[0].get('contact'),
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
                          const Text("자기소개 (선택)"),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              initialValue: snapshot.data!.docs[0].get('introduce'),
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
                                child: Text('제출하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                onPressed: () async {
                                  if (name != null && year != null && month != null && day != null && superiorNumber != null && contact != null && introduce != null){
                                    DocumentReference reference = await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc("RgQkZUyaYpPzfTmgs5y9");
                                    await reference.update({
                                      'id': reference.id,
                                      'uid': FirebaseAuth.instance.currentUser!.uid,
                                      'curTime': FieldValue.serverTimestamp(),
                                      'name': name,
                                      'year': year,
                                      'month': month,
                                      'day': day,
                                      'superiorNumber': superiorNumber,
                                      'contact': contact,
                                      'introduce': introduce,
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChartPage()),
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
              ]);
        }
      ),
    );
  }
}
