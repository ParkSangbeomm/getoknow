// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
//
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// import '../utils.dart';
//
//
// class CalendarPage extends StatefulWidget {
//   const CalendarPage({Key? key}) : super(key: key);
//
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }
//
// class _CalendarPageState extends State<CalendarPage> {
//   late final ValueNotifier<List<Event>> _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//       .toggledOff; // Can be toggled on/off by longpressing a date
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }
//
//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }
//
//   List<Event> _getEventsForDay(DateTime day) {
//     // Implementation example
//     return kEvents[day] ?? [];
//   }
//
//   List<Event> _getEventsForRange(DateTime start, DateTime end) {
//     // Implementation example
//     final days = daysInRange(start, end);
//
//     return [
//       for (final d in days) ..._getEventsForDay(d),
//     ];
//   }
//
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _rangeStart = null; // Important to clean those
//         _rangeEnd = null;
//         _rangeSelectionMode = RangeSelectionMode.toggledOff;
//       });
//
//       _selectedEvents.value = _getEventsForDay(selectedDay);
//     }
//   }
//
//   void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//     setState(() {
//       _selectedDay = null;
//       _focusedDay = focusedDay;
//       _rangeStart = start;
//       _rangeEnd = end;
//       _rangeSelectionMode = RangeSelectionMode.toggledOn;
//     });
//
//     // `start` or `end` could be null
//     if (start != null && end != null) {
//       _selectedEvents.value = _getEventsForRange(start, end);
//     } else if (start != null) {
//       _selectedEvents.value = _getEventsForDay(start);
//     } else if (end != null) {
//       _selectedEvents.value = _getEventsForDay(end);
//     }
//   }
//   late String event;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar - Events'),
//       ),
//       body: StreamBuilder<Object>(
//         stream: FirebaseFirestore.instance
//             .collection('Users')
//             .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (context, AsyncSnapshot snapshot) {
//           return Column(
//             children: [
//               TableCalendar<Event>(
//                 firstDay: kFirstDay,
//                 lastDay: kLastDay,
//                 focusedDay: _focusedDay,
//                 selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//                 rangeStartDay: _rangeStart,
//                 rangeEndDay: _rangeEnd,
//                 calendarFormat: _calendarFormat,
//                 rangeSelectionMode: _rangeSelectionMode,
//                 eventLoader: _getEventsForDay,
//                 //eventLoader: snapshot.data!.docs[0].get('event'),
//                 startingDayOfWeek: StartingDayOfWeek.monday,
//                 calendarStyle: CalendarStyle(
//                   // Use `CalendarStyle` to customize the UI
//                   outsideDaysVisible: false,
//                 ),
//                 onDaySelected: _onDaySelected,
//                 onRangeSelected: _onRangeSelected,
//                 onFormatChanged: (format) {
//                   if (_calendarFormat != format) {
//                     setState(() {
//                       _calendarFormat = format;
//                     });
//                   }
//                 },
//                 onPageChanged: (focusedDay) {
//                   _focusedDay = focusedDay;
//                 },
//               ),
//               const SizedBox(height: 8.0),
//               Expanded(
//                 child: ValueListenableBuilder<List<Event>>(
//                   valueListenable: _selectedEvents,
//                   builder: (context, value, _) {
//                     if (value.length != 0) {
//                       return ListView.builder(
//                           itemCount: value.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: const EdgeInsets.symmetric(
//                                 horizontal: 12.0,
//                                 vertical: 4.0,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(),
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ),
//                               child: ListTile(
//                                 onTap: () => print('${value[index]}'),
//                                 title: Text('${value[index]}'),
//                               ),
//                             );
//                           }
//                       );
//                     }
//                     else {
//                       return Column(
//                         children: [
//                           SizedBox(
//                             height: 5, // ?????? ??????
//                           ),
//                           Text(
//                             "????????? ?????????!",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3, // ?????? ??????
//                           ),
//                           Container(
//                             child: TextButton(
//                               onPressed: () {
//                                 Alert(
//                                     context: context,
//                                     title: "??? ?????? ??????",
//                                     content: Column(
//                                       children: <Widget>[
//                                         TextFormField(
//                                             decoration: InputDecoration(
//                                               icon: Icon(
//                                                   Icons.account_circle),
//                                               labelText: '??? ??????',
//                                             ),
//                                             onChanged: (value) {
//                                               event = value;
//                                             }
//                                         ),
//                                       ],
//                                     ),
//                                     buttons: [
//                                       DialogButton(
//                                         onPressed: () async {
//                                           print("hi");
//                                           DocumentReference reference = await FirebaseFirestore.instance
//                                               .collection('Events')
//                                               .doc();
//
//                                           await reference.set({
//                                             'id': reference.id,
//                                             'uid': FirebaseAuth.instance.currentUser!.uid,
//                                             'curTime': FieldValue.serverTimestamp(),
//                                             'eventDate': _selectedDay,
//                                             'event': event,
//                                           });
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text(
//                                           "??????",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 20),
//                                         ),
//                                       )
//                                     ]).show();
//                               },
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.fromLTRB(
//                                     MediaQuery
//                                         .of(context)
//                                         .size
//                                         .width * 0.03,
//                                     0,
//                                     MediaQuery
//                                         .of(context)
//                                         .size
//                                         .width * 0.03,
//                                     0),
//                                 minimumSize: Size(70, 40),
//                                 alignment: Alignment.center,
//                                 backgroundColor: Color(0xff9bb7e7),
//                                 shape: StadiumBorder(
//                                   side: BorderSide(
//                                       color: Color(0xff9bb7e7), width: 2),
//                                 ),
//                               ),
//                               child: const Text(
//                                 '??????',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xfff3f0f0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatefulWidget {

  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  bool loading = false;

  DateTime? appointmentDate;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment With My Superior")
      ),
      body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          return Column(
            children: [
              TableCalendar(
                onDaySelected: (selectDay, focussedDay) {
                  setState(() {
                    selectedDay = selectDay;
                    appointmentDate = selectDay;
                    //  finalAppointment = selecctDay;
                    focusedDay = focussedDay;
                  });
                },
                firstDay: DateTime(2021),
                focusedDay: selectedDay,
                lastDay: DateTime(2050),
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
              loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  CollectionReference appointment =
                  firestore.collection('appointments');

                  if (appointmentDate == null) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'You should tap the date which you want to book'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    QuerySnapshot allresults = await FirebaseFirestore
                        .instance
                        .collection('appointments')
                        .where('day', isEqualTo: selectedDay)
                        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get();

                    if (allresults.docs.isEmpty) {
                      User? user = firebaseAuth.currentUser;
                      String userid = user!.uid;

                      await appointment.add({
                        'userid': userid,
                        'day': selectedDay,
                        'name': user.email,
                        'superiorNumber': snapshot.data!.docs[0].get('superiorNumber'),
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('appointment set'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    }

                    if (allresults.docs.isNotEmpty) {
                      setState(() {
                        loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Already appointed'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }

                  // });
                },
                child: const Text('set appointment'),
              )
            ],
          );
        }
      ),
    );
  }
}
