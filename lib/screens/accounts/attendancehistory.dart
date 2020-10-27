import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistory extends StatefulWidget {
  final String email;
  final DocumentSnapshot document;
  AttendanceHistory({this.email, this.document});
  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  DocumentSnapshot documentSnapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    documentSnapshot = widget.document;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance History"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                documentSnapshot.data["subjectName"] == null
                    ? "no data"
                    : "Subject : " + documentSnapshot.data["subjectName"],
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text('Attendance is sorted according to the Date',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 12)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Date",
                    style: TextStyle(
                        color: Colors.deepOrangeAccent, fontSize: 14)),
                Text("Status",
                    style:
                        TextStyle(color: Colors.deepOrangeAccent, fontSize: 14))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("users")
                  .document(widget.email)
                  .collection("attendance_data")
                  .document(documentSnapshot.documentID)
                  .collection("history")
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (c, snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot doc = snapshot.data.documents[index];
                          Timestamp time = doc.data["time"];
                          String _printedTime = time.toDate().hour.toString() +
                              ":" +
                              time.toDate().minute.toString() +
                              "  " +
                              time.toDate().day.toString() +
                              "-" +
                              time.toDate().month.toString() +
                              "-" +
                              time.toDate().year.toString();
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                          doc.data["time"] == null
                                              ? "no data"
                                              : _printedTime,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                      Text(
                                          doc.data["status"] == null
                                              ? "no data"
                                              : doc.data["status"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14))
                                    ],
                                  ),
                                )),
                          );
                        }),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
