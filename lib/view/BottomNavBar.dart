import 'package:flutter/material.dart';

import 'Admin Module/AddLocationScreen.dart';
import 'Admin Module/AdminDashboardScreen.dart';

import 'User Module/UploadExcelScreen.dart';
import 'User Module/UserDashboardScreen.dart';
import 'User Module/WeatherReportScreen.dart';

class NavbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String userRole;

  const NavbarWidget({required this.userRole});

  @override
  Widget build(BuildContext context) {
    // You can customize based on user role here
    return AppBar(
      title: Text('App Name'),
      actions: <Widget>[
        // Add more actions or buttons depending on the user role
        if (userRole == 'admin')
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () {
              // Admin-specific action
            },
          ),
        if (userRole == 'user')
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // User-specific action
            },
          ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // Common logout action
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class FooterWidget extends StatelessWidget {
  final String userRole;

  const FooterWidget({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _getFooterActions(context),
      ),
    );
  }

  List<Widget> _getFooterActions(BuildContext context) {
    if (userRole == 'admin') {
      return [
        IconButton(
          icon: Icon(Icons.dashboard),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admindashboardscreen(role: '',)),
               );
          },
        ),
        IconButton(
          icon: Icon(Icons.add_location),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addlocationscreen()),
            );
          },
        ),
      ];
    } else if (userRole == 'user') {
      return [
        IconButton(
          icon: Icon(Icons.dashboard),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Userdashboardscreen( Role: '',)),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.upload_file),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Uploadexcelscreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.cloud),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Weatherreportscreen()),
            );
          },
        ),
      ];
    } else {
      return [];
    }
  }
}

