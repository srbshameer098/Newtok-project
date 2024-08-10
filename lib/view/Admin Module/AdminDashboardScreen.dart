import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Authentication/Login/Login.dart';
import '../BottomNavBar.dart';


class Admindashboardscreen extends StatefulWidget {
  const Admindashboardscreen({super.key, required this.role});
  final String role;



  @override
  State<Admindashboardscreen> createState() => _AdmindashboardscreenState();
}


class _AdmindashboardscreenState extends State<Admindashboardscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard'),
          actions: [
            IconButton(
          onPressed: () {
    logout(context);
    },
      icon: Icon(
        Icons.logout,
      ),
            )
          ],
    ),

    body: Center(child: Text('Welcome, Admin'
    )
    )
    ,
bottomNavigationBar: FooterWidget(userRole:comment),


    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }



}
