import 'package:agro/main.dart';
import 'package:flutter/material.dart';
import 'package:agro/dieases.dart';
import 'package:agro/about.dart';

class SideDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SideDrawerState();
  }
}

class SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green, // Set the background color to green
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 50,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                ),
                Center(
                  child: Text(
                    'Agro Leaf',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.green, // Icon color is green
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, camerahome);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_florist,
              color: Colors.green, // Icon color is green
            ),
            title: Text('Diseases Category'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DiseaseCategory(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.green, // Icon color is green
            ),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
          // Add more drawer items as needed
        ],
      ),
    );
  }
}
