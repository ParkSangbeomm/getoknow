import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphview/GraphView.dart';

import '../utils.dart';
import 'calendar.dart';
import 'googlemap.dart';
import 'edit_info.dart';

List<Node> node = <Node>[];
Map<int, int> myNumberIndex = {0:0,};
Map<int, int>? superMyNumber = {0:0,};
Map<int, String> names={0:"no",};
String? orCode;

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("  Organization Chart", textAlign: TextAlign.right, style: TextStyle(color: Color(0xff9bb7e7), fontSize: 25, fontWeight: FontWeight.bold)),
                            Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.blueAccent,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CalendarPage()),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.blueAccent,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FindgymPage()),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.blueAccent,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                                );
                              },
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            const Text('   개인 일련번호: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(snapshot.data.docs[0].get('myNumber'), style: TextStyle(fontSize: 15)),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 20),
                              onPressed:() async {
                                await Clipboard.setData(ClipboardData(text: snapshot.data!.docs[0].get('myNumber')));
                              },
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ]),
                      Row(
                          children: [
                            const Text('   기관 코드: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(snapshot.data.docs[0].get('organizationCode'), style: TextStyle(fontSize: 15)),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 20),
                              onPressed:() async {
                                await Clipboard.setData(ClipboardData(text: snapshot.data!.docs[0].get('organizationCode')));
                              },
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ]),
                      Wrap(
                        children: [
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue: builder.siblingSeparation.toString(),
                              decoration: InputDecoration(labelText: "Sibling Separation"),
                              onChanged: (text) {
                                builder.siblingSeparation = int.tryParse(text) ?? 100;
                                this.setState(() {});
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue: builder.levelSeparation.toString(),
                              decoration: InputDecoration(labelText: "Level Separation"),
                              onChanged: (text) {
                                builder.levelSeparation = int.tryParse(text) ?? 100;
                                this.setState(() {});
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue: builder.subtreeSeparation.toString(),
                              decoration: InputDecoration(labelText: "Subtree separation"),
                              onChanged: (text) {
                                builder.subtreeSeparation = int.tryParse(text) ?? 100;
                                this.setState(() {});
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue: builder.orientation.toString(),
                              decoration: InputDecoration(labelText: "Orientation"),
                              onChanged: (text) {
                                builder.orientation = int.tryParse(text) ?? 100;
                                this.setState(() {});
                              },
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              final node12 = Node.Id(r.nextInt(100));
                              var edge = graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                              print(edge);
                              graph.addEdge(edge, node12);
                              setState(() {});
                            },
                            child: Text("Add"),
                          )
                        ],
                      ),
                      FutureBuilder(
                        future: init(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData == false) {
                            return CircularProgressIndicator();
                          }else{
                          return Expanded(
                            child: InteractiveViewer(
                                constrained: false,
                                boundaryMargin: EdgeInsets.all(100),
                                minScale: 0.01,
                                maxScale: 5.6,
                                child: GraphView(
                                  graph: graph,
                                  algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                                  paint: Paint()
                                    ..color = Colors.green
                                    ..strokeWidth = 1
                                    ..style = PaintingStyle.stroke,
                                  builder: (Node node) {
                                    // I can decide what widget should be shown here based on the id
                                    var a = node.key!.value as int;
                                    return rectangleWidget(a);
                                  },
                                )),
                          );}
                        }
                      ),
                    ]),
              ),
            );
          }
      ),
    );
  }
  Random r = Random();

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        print('clicked');
        print(orCode);
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blueAccent, spreadRadius: 1),
            ],
          ),
          child: Text(names[a] as String)),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  init() async{
    // Future.delayed(Duration.zero,() async {
    //   await _setting();
    // });
    await _setting();

    // for(var i=0;i<numbers.length;i++){
    //   node.add(Node.Id(numbers(i)));
    // }
    // node.add(Node.Id(100));
    // node.add(Node.Id(2));
    //
    print(node);
    //graph.addEdge(node[0], node[1]);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
  void asyncM() async{
    await _setting();
  }
  _setting() async{
    int? size;
    await fireStore.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((querySnapshot) {
      orCode = querySnapshot.get("organizationCode");
      //print(querySnapshot.get("name"));
    });

    // final Map<String, Node> _nodes = {};
    int count=1;
    await fireStore.collection("Users").where('organizationCode',isEqualTo: orCode).get().then((querySnapshot){
      for(var result in querySnapshot.docs){
        names[int.parse(result.get("myNumber"))] = result.get("name");
        myNumberIndex[int.parse(result.get("myNumber"))] = count;
        superMyNumber![int.parse(result.get("myNumber"))] = int.parse(result.get("superiorNumber"));
        node.add(Node.Id(int.parse(result.get("myNumber"))));
        //print("test");
        //print(Node.Id(int.parse(result.get("myNumber"))));
        //print(node);
        count++;
        //size = querySnapshot.size;
      }
    });
    for(var i=0;i<node.length;i++){
      var val = node[i].key!.value;
      int s = myNumberIndex[superMyNumber![val]] as int;
      graph.addEdge(node[s], node[i]);
    }
  }
}