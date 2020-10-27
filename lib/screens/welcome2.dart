import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:giiiii/main.dart';
import 'package:giiiii/screens/accounts/attendancehistory.dart';

class welcome2 extends StatefulWidget {
  final String userEmail;
  welcome2({this.userEmail});
  @override
  _welcome2State createState() => _welcome2State();
}

class _welcome2State extends State<welcome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.blueGrey[900],
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            
            width: double.infinity,
            padding: EdgeInsets.only(top: 70, right: 30),
            decoration: BoxDecoration(
                image:DecorationImage(image: AssetImage('images/welcome.jpg',),fit:BoxFit.fitWidth),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(220)),
                color: Colors.tealAccent),
            // child: Text('Welcome!',
            //     textAlign: TextAlign.right,
            //     style: TextStyle(color: Colors.red, fontSize: 50)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, top: 30),
            child: Text(
                'Your Subject-wise Attendance Summary for current semeseter',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 17,fontFamily: 'Pacifico')),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("users")
                .document(widget.userEmail)
                .collection("attendance_data")
                .snapshots(),
            builder: (c, snapshot) {
              if (snapshot.data != null) {
                return Container(
                    height: 350, child: buidlSubjectHistory(snapshot.data));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            // width: double.infinity,
            child: RaisedButton(
              elevation: 3.0,
              onPressed: () {
                updateAttendance();
              },
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.black,
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buidlSubjectHistory(QuerySnapshot data) {
    return GridView.count(
        crossAxisCount: 2,
        primary: false,
        padding: const EdgeInsets.all(20),
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        children: data.documents
            .map((doc) => InkWell(
                  onTap: doc.data != null
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => AttendanceHistory(
                                        email: widget.userEmail,
                                        document: doc,
                                      )));
                        }
                      : null,
                  child: blockSubject(doc),
                ))
            .toList());
  }

  Widget blockSubject(DocumentSnapshot doc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 7,
          width: double.infinity,
        ),
        Text(
          doc.data["subjectName"] == null ? "no data" : doc.data["subjectName"],
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        doc.data["totalPeriods"] != null &&
                (doc.data["totalPeriods"] != 0 &&
                    doc.data["presentPeriods"] != 0)
            ? Column(
                children: <Widget>[
                  Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: AnimatedCircularChart(
                        
                        chartType: CircularChartType.Radial,
                        holeLabel: doc.data["presentPeriods"].toString() +
                            "/" +
                            doc.data["totalPeriods"].toString(),
                        labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        initialChartData: <CircularStackEntry>[
                          new CircularStackEntry(
                            <CircularSegmentEntry>[
                              new CircularSegmentEntry(
                                doc.data["presentPeriods"] /
                                    doc.data["totalPeriods"] *
                                    100,
                                Colors.orangeAccent,
                                rankKey: 'starred',
                              ),
                              new CircularSegmentEntry(
                                (1 -
                                        doc.data["presentPeriods"] /
                                            doc.data["totalPeriods"]) *
                                    100,
                                Colors.white,
                                rankKey: 'total',
                              ),
                            ],
                            rankKey: 'progress',
                          ),
                        ],
                        percentageValues: true,
                        size: const Size(60.0, 60.0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${doc.data["presentPeriods"].toString()} periods present",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              )
            : Container(
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: Text(
                    "No data yet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              )
      ],
    );
  }

  updateAttendance() async {
    showToast("Updating..Please Wait");
    await Firestore.instance
        .collection("users")
        .document(widget.userEmail)
        .collection("attendance_data")
        .getDocuments()
        .then((onValue) {
      if (onValue != null && onValue.documents != null) {
        onValue.documents.forEach((doc) {
          updateSubject(doc.documentID);
        });
      }
    });
  }

  updateSubject(String documentID) async {
    Firestore.instance
        .collection("users")
        .document(widget.userEmail)
        .collection("attendance_data")
        .document(documentID)
        .get()
        .then((document) async {
      if (document.data != null) {
        int totalPeriods = 0;
        int presentPeriods = 0;

        await Firestore.instance
            .collection("users")
            .document(widget.userEmail)
            .collection("attendance_data")
            .document(documentID)
            .collection("history")
            .getDocuments()
            .then((onValue) {
          if (onValue != null && onValue.documents != null) {
            totalPeriods = onValue.documents.length;
            for (int i = 0; i < onValue.documents.length; ++i) {
              if (onValue.documents[i].data["status"].toString() == "present") {
                presentPeriods++;
              }
            }
          }
        });
        await Firestore.instance
            .collection("users")
            .document(widget.userEmail)
            .collection("attendance_data")
            .document(documentID)
            .setData({
          "totalPeriods": totalPeriods,
          "presentPeriods": presentPeriods
        }, merge: true);
        setState(() {});
      }
    });
  }
}

//  Container(
//             alignment: Alignment.center,
//             margin: EdgeInsets.only(top: 100),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: Firestore.instance
//                     .collection("users")
//                     .document(widget.userEmail)
//                     .collection("data")
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.data!=null) {
//                     return Column(
//                         children: snapshot.data.documents
//                             .map((doc) => buildItem(doc))
//                             .toList());
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ),
//           )

Card buildItem(DocumentSnapshot doc) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Period 1:  '
            '${doc.data['period_1']}',
            style: TextStyle(fontSize: 24.0),
          ),
          Text(
            'Period 2:  '
            '${doc.data['period_2']}',
            style: TextStyle(fontSize: 24.0),
          ),
          Text(
            'Period 3:  '
            '${doc.data['period_3']}',
            style: TextStyle(fontSize: 24.0),
          ),
          Text(
            'Period 4:  '
            '${doc.data['period_4']}',
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    ),
  );
}
