import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getoknow/src/table_calendar.dart';
import 'package:getoknow/table_calendar.dart';
import 'package:graphview/GraphView.dart';

import '../utils.dart';
import 'calendar.dart';
import 'edit_info.dart';
import 'src/table_calendar.dart';
import 'table_calendar.dart';

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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Organization Chart", textAlign: TextAlign.right, style: TextStyle(color: Color(0xff9bb7e7), fontSize: 25, fontWeight: FontWeight.bold)),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CalendarPage()),
                      // );
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
              Expanded(
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
              ),
          ]),
        ),
      ),
    );
  }
  Random r = Random();

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blueAccent, spreadRadius: 1),
            ],
          ),
          child: Text('Node ${a}')),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);

    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    graph.addEdge(node4, node9);
    graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}


