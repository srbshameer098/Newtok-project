import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Authentication/Login/Login.dart';
import '../BottomNavBar.dart';


class Userdashboardscreen extends StatefulWidget {
  const Userdashboardscreen({super.key, required this.Role});
  final String Role;
  @override
  State<Userdashboardscreen> createState() => _UserdashboardscreenState();
}

class _UserdashboardscreenState extends State<Userdashboardscreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(title: Text('User Dashboard'),

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              padding: EdgeInsets.all(16),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Country: ${data['country']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('State: ${data['state']}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('District: ${data['district']}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('City: ${data['city']}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('No locations found'));
          }
        },
      ),
      bottomNavigationBar:  FooterWidget(userRole: comment),



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
