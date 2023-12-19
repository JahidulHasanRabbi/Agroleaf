import 'package:flutter/material.dart';
import 'package:agro/main.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here (e.g., navigate back to the camera screen)
        Navigator.pushNamed(context, camerahome);
        return true; // Return true to allow the back button press
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('About'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, camerahome);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/me.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Jahidul Hasan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'I am Jahidul Hasan, and this application has been meticulously crafted to serve the purpose of my thesis paper, focusing on the detection of rice leaf diseases through the application of a sophisticated Hybrid Machine Learning Algorithm. This cutting-edge solution leverages a robust machine learning model to accurately predict and diagnose various rice leaf diseases.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
