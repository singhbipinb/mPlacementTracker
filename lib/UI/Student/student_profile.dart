import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mplacementtracker/UI/Student/student_dashboard.dart';
import 'package:mplacementtracker/model/user.dart';
import 'package:mplacementtracker/UI/widgets/header_widget.dart';
import 'package:mplacementtracker/services/helper.dart';
import '../../main.dart';
import '../login_page.dart';

class StudentProfile extends StatefulWidget{
final User user;

  StudentProfile({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile>{
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Data",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColorLight, Theme.of(context).accentColor,]
              )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColorLight.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColorLight,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("Role: Student",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(color: Theme.of(context).accentColor, height: 1,),
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Dashboard',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () async {
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, StudentDashboard(), true);
                 },
              ),
              
              Divider(color: Theme.of(context).primaryColorLight, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                 onTap: () async {
                await auth.FirebaseAuth.instance.signOut();
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, LoginPage(), false);
                 },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                      ],
                    ),
                    child: 
                    displayCircleImage(user.profilePictureURL, 100, false),
                  ),
                  SizedBox(height: 20,),
                  Text(user.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text('Student', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.book),
                                          title: Text("Name"),
                                          subtitle: Text(user.name),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.book),
                                          title: Text("Roll No."),
                                          subtitle: Text("180017"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.contacts),
                                          title: Text("Contact No."),
                                          subtitle: Text("9876543210"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Personal Email"),
                                          subtitle: Text(user.email),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.book),
                                          title: Text("Graduation Percentage"),
                                          subtitle: Text("81"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.book),
                                          title: Text("Active Backlogs"),
                                          subtitle: Text("0"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.location_city),
                                          title: Text("Current Residence"),
                                          subtitle: Text("Mullana"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.location_city),
                                          title: Text("Permanent Address"),
                                          subtitle: Text("MMDU, Mullana"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}