import 'dart:async';

import 'package:booknbooks/detail.dart';
import 'package:flutter/material.dart';
import 'package:booknbooks/home.dart';
import 'package:booknbooks/explore.dart';
import 'package:booknbooks/settings.dart';
import 'package:booknbooks/widgets.dart';
import 'package:booknbooks/data.dart';

import 'oauth.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context)=>Loading(),
      '/home': (context)=>Home(),
      '/settings':(context)=>Settings(),
      '/explore':(context)=>Explore(),
      '/detail':(context)=>BookDetail(),
      '/auth':(context)=>authentication()
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
      Navigator.pushNamed(context, '/auth')
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(child: Text('Loading...'))
    );
  }
}


