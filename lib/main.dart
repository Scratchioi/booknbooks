import 'dart:async';

import 'package:flutter/material.dart';
import 'package:booknbooks/home.dart';
import 'package:booknbooks/explore.dart';
import 'package:booknbooks/settings.dart';
import 'package:booknbooks/widgets.dart';
import 'package:booknbooks/data.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context)=>Loading(),
      '/home': (context)=>Home(),
      '/settings':(context)=>Settings(),
      '/explore':(context)=>Explore(),
    }
  ));
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  @override
  void initState(){
    Timer(
      Duration(seconds: 3),()=>
      Navigator.pushNamed(context, '/home')
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Text('Loading...')
    );
  }
}


