import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giiiii/main.dart';

class Realtime extends StatefulWidget {
  @override
  _RealtimeState createState() => _RealtimeState();
}

class _RealtimeState extends State<Realtime> {
  String dropdownval;
  List<String> subjects = ["subjectA", "subjectB", "subjectC", "subjectD"];
  bool updateProgress = false;
  String textProgress = "checking the student tags";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Attendance"),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Attendance Recorded",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: RaisedButton(
                      elevation: 1.0,
                      onPressed: () {
                        clearAttendance();
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.orange,
                      child: Text(
                        'clear all',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("UID").snapshots(),
                builder: (c, snapshot) {
                  if (snapshot.data != null) {
                    return Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) {
                            DocumentSnapshot doc =
                                snapshot.data.documents[index];

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
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Student with Tag : ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                        Text(doc.data["tag"],
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
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 160,
                child: Material(
                  elevation: 14,
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: updateProgress
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  textProgress,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 18),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 60, right: 60),
                                  child: DropdownButton<dynamic>(
                                    hint: Text(
                                      "please select a subject for the recorded attendance",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 12),
                                    ),
                                    isExpanded: true,
                                    value: dropdownval,
                                    iconSize: 30,
                                    onChanged: (val) {
                                      setState(() {
                                        this.dropdownval = val;
                                      });
                                    },
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                    items: subjects.map((val) {
                                      return DropdownMenuItem(
                                          value: val,
                                          child: Text(val.toString()));
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 70),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 1.0,
                                    onPressed: () {
                                      if (dropdownval == null) {
                                        showToast(
                                            "please select a subject first!");
                                      } else
                                        uploadAttendance();
                                    },
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.orange,
                                    child: Text(
                                      'add',
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void uploadAttendance() async {
    setState(() {
      updateProgress = true;
    });
    List<String> tagList = [];
    try {
      await Firestore.instance.collection("UID").getDocuments().then((onValue) {
        if (onValue.documents != null) {
          for (int i = 0; i < onValue.documents.length; ++i) {
            tagList.add(onValue.documents[i].data["tag"]);
          }
        }
      });
      print(tagList);
      setState(() {
        textProgress = "assigning attendance status";
      });
      await Firestore.instance.collection("users").getDocuments().then((value) {
        if (value.documents != null) {
          if (tagList.isNotEmpty) {
            value.documents.forEach((doc) {
              if (tagList.contains(doc.data["uid"])) {
                Firestore.instance
                    .collection("users")
                    .document(doc.documentID)
                    .collection("attendance_data")
                    .document(dropdownval)
                    .collection("history")
                    .add({"time": Timestamp.now(), "status": "present"});
                print("present");
              } else {
                Firestore.instance
                    .collection("users")
                    .document(doc.documentID)
                    .collection("attendance_data")
                    .document(dropdownval)
                    .collection("history")
                    .add({"time": Timestamp.now(), "status": "absent"});
                print("absent");
              }
              Firestore.instance
                  .collection("users")
                  .document(doc.documentID)
                  .collection("attendance_data")
                  .document(dropdownval)
                  .setData({"subjectName": dropdownval}, merge: true);
            });
          } else{
            showToast("no attendance data");
          }
        }
      });
      setState(() {
        updateProgress = false;
        textProgress = "checking the student tags";
      });
    } catch (e) {
      setState(() {
        updateProgress = false;
        textProgress = "checking the student tags";
      });
    }
  }

  void clearAttendance() async {
    showToast("clearing attendance");
    await Firestore.instance.collection("UID").getDocuments().then((onValue) {
      if (onValue.documents != null) {
        onValue.documents.forEach((doc) {
          Firestore.instance
              .collection("UID")
              .document(doc.documentID)
              .delete();
        });
      }
    });
  }
}
