import 'package:flutter/material.dart';


class Dev extends StatefulWidget {
  Dev({Key key}) : super(key: key);

  @override
  _DevState createState() => _DevState();
}

class _DevState extends State<Dev> {
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
              image:DecorationImage(image: AssetImage('images/kk.jpg'),fit:BoxFit.fitWidth),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                color: Colors.amber[800]),
            child: Align(
                        child: Text('Developers',
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.amber[800], fontSize: 60,fontFamily: 'Pacifico',)),
                  alignment: Alignment(-1, 0),
            ),
          ),
          SizedBox(height: 70),
          Card(
           // height: 70,
           color: Colors.grey[700],
           margin: EdgeInsets.all(20),
            child: Padding(
                          child: ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage('images/dev.jpg'),radius: 38,),
                title: Text('Akhil.M',
                textAlign: TextAlign.center,
                style: TextStyle(
                   fontSize: 30,
                      fontFamily: 'pacifico',
                ),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
           Card(
           // height: 70,
           color: Colors.grey[700],
           margin: EdgeInsets.all(20),
            child: Padding(
                          child: ListTile(
               leading: CircleAvatar(backgroundImage: AssetImage('images/dev2.jpeg'),radius: 38,),
                title: Text('Ahlad v.k',
                textAlign: TextAlign.center,
                style: TextStyle(
                   fontSize: 30,
                      fontFamily: 'pacifico',
                ),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
          Card(
           // height: 70,
           color: Colors.grey[700],
           margin: EdgeInsets.all(20),
            child: Padding(
                          child: ListTile(
               leading: CircleAvatar(backgroundImage: AssetImage('images/dev3.jpeg'),radius: 38,),
                title: Text('Ajay e.k',
                textAlign: TextAlign.center,
                style: TextStyle(
                   fontSize: 30,
                      fontFamily: 'pacifico',
                ),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
           Card(
           // height: 70,
           color: Colors.grey[700],
           margin: EdgeInsets.all(20),
            child: Padding(
                          child: ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage('images/dev4.jpg'),radius: 38,),
                title: Text('AgilKrishna',
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