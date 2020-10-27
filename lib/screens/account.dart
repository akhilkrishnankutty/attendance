import 'package:flutter/material.dart';
import 'package:giiiii/intro.dart';
import 'package:giiiii/screens/accounts/circular.dart';
import 'package:giiiii/screens/accounts/complaints.dart';
import 'package:giiiii/screens/accounts/dev.dart';
import 'package:giiiii/screens/accounts/facintro.dart';
import 'package:giiiii/screens/accounts/leave.dart';
import 'package:giiiii/screens/accounts/stuseries.dart';
import 'package:giiiii/screens/accounts/timetable.dart';
import 'accounts/chat.dart';

class Accounts extends StatefulWidget {
   final String userEmail;
  Accounts({this.userEmail});
  

 
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
       body: ListView(
         children: <Widget>[
           UserAccountsDrawerHeader(
             accountEmail: null,
             accountName: Text(widget.userEmail,
             style: TextStyle(
               color: Colors.black,
               fontFamily: 'Pacifico',
               fontSize: 30
             ),
             ),
             decoration: BoxDecoration(color: Colors.teal,
             image:DecorationImage(image: AssetImage('images/student.jpg'))
             ),
            // currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('/u/0/project/attiles/post.jpg'),),
           ),
          InkWell(
            child:  ListTile(
             title: Text('Chats',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.chat,color: Colors.white,),
             onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) =>FirestoreCRUDPage ()));}
           ),
          ),
           ListTile(
             title: Text('Apply leave',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.credit_card,color: Colors.white,),
              onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Leave()));}
           ),
           ListTile(
             title: Text('Series mark',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.content_paste,color: Colors.white),
              onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => stuseries(userEmail: widget.userEmail,)));}
           ),
           
           
            ListTile(
             title: Text('E-circular',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.find_in_page,color: Colors.white),
             onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Circular()));}
           ),
            ListTile(
             title: Text('Time Table',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.calendar_today,color: Colors.white),
             onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Timetable()));}
           ),
            ListTile(
             title: Text('Complaints',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.calendar_today,color: Colors.white),
             onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Complaints()));}
           ),
          //  ListTile(
          //    title: Text('Faculty'),
          //    trailing: Icon(Icons.person),
          //    onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Facinto()));}
          //   ),
            ListTile(
             title: Text('Developers',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.developer_mode,color: Colors.white),
             onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Dev()));}
            ),
             ListTile(
             title: Text('Log out',style: TextStyle(color: Colors.white),),
             trailing: Icon(Icons.exit_to_app,color: Colors.white),
             onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => Intro()));}
            )
         ],
       ),
    );
  }
}
