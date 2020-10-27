import 'package:flutter/material.dart';

class Facinto extends StatefulWidget {
  Facinto({Key key}) : super(key: key);

  @override
  _FacintoState createState() => _FacintoState();
}

class _FacintoState extends State<Facinto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
             Container(
            height: 200,
            width: 500,
            padding: EdgeInsets.only(top: 70, left: 70),
            decoration: BoxDecoration(
              image:DecorationImage(image: AssetImage('images/fac.jpg'),fit:BoxFit.fitWidth),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                color: Colors.amber[800]),
            child: Align(
                        child: Text('Faculty',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.amber[800], fontSize: 60,fontFamily: 'Pacifico',)),
                  alignment: Alignment(-0.5, 0),
            ),
          ),
          SizedBox(height: 70),
          Card(
           // height: 70,
           color: Colors.grey[700],
           margin: EdgeInsets.all(20),
            child: Padding(
                          child: ListTile(
                leading: CircleAvatar(//backgroundImage: AssetImage('images/lll.jpg'),radius: 38,
                ),
                title: Text('Anu Rinny Sunny',
                textAlign: TextAlign.center,
                style: TextStyle(
                   fontSize: 30,
                      fontFamily: 'pacifico',
                ),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          )
        
          ],
        ),
      ),
    );
  }
}