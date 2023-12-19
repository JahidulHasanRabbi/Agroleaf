import 'package:agro/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  // Wait for 2 seconds and then navigate to the main app widget
  Future<void> _navigateToMain() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed(camerahome);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSplashScreen();
  }
}

class CustomSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Background color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment(0.0, -0.3),
            child: Image.asset(
              'assets/logo-1.png',
              width: 200,
              height: 200,
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.5),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Agro Leaf',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(12, 155, 17, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
