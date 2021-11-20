import 'dart:async';
import 'dart:io';

import 'package:booknbooks/detail.dart';
import 'package:booknbooks/readbook.dart';
import 'package:booknbooks/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:booknbooks/home.dart';
import 'package:booknbooks/explore.dart';
import 'package:booknbooks/settings.dart';
import 'package:booknbooks/widgets.dart';
import 'package:booknbooks/data.dart';
import 'oauth.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:booknbooks/bookread.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context)=>Loading(),
      '/home': (context)=>Home(),
      '/settings':(context)=>Settings(),
      '/explore':(context)=>Explore(),
      '/detail':(context)=>BookDetail(),
      '/auth':(context)=>authentication(),
      '/readbook':(context)=>bookRead(),
      '/search' : (context)=>searchPage(),

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
  initState(){
    checkLoginState();
  }

  checkLoginState() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    try {
      var token = await File('${appDocumentsDirectory.path}/token.txt')
          .readAsString();
      print('token :-> $token');
      if (token != '') {
        auth_token = token;
        Navigator.popAndPushNamed(context, '/home');
      }
      else {
        Navigator.popAndPushNamed(context, '/auth');
      }
    }
    catch(e) {
      print('error occured: ${e.toString()}');
      Navigator.popAndPushNamed(context, '/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body:
        Center(child: textData(
          info: 'Loading...',
          toBold: true,
          size: 28,
        ))
    );
  }
}


