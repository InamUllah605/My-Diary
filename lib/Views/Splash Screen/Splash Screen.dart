import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_diary/Views/Home%20Screen/Home%20Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),));
    });
    return Scaffold(backgroundColor: Colors.teal,
      body: Center(child: Text('My Diary',style: TextStyle(fontSize: 30,color: Colors.white),),),
    );
  }
}
