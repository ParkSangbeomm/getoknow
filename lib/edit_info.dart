import 'package:flutter/material.dart';

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
                          backgroundImage: AssetImage('img/profile.png'),
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
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
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
                              ),
                            ),
                            const Text(" 일"),
                          ]),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("상관 이름 / 일련 번호"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextField(
                          controller: superiorNameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("Contact (선택)"),
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
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      const Text("자기소개 (선택)"),
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
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                            child: Text('제출하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            onPressed: () {
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
