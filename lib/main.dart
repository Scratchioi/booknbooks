import 'dart:async';
import 'dart:io';

import 'package:booknbooks/db.dart';
import 'package:booknbooks/detail.dart';
import 'package:booknbooks/readbook.dart';
import 'package:booknbooks/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:booknbooks/home.dart';
import 'package:booknbooks/explore.dart';
import 'package:booknbooks/settings.dart';
import 'package:booknbooks/widgets.dart';
import 'package:booknbooks/data.dart';
import 'homehome.dart';
import 'oauth.dart';
import 'package:path_provider/path_provider.dart';

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
      '/homehome': (context)=>HomeHome()

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
    print('---started login check---');
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    try {
      var token = await File('${appDocumentsDirectory.path}/token.txt')
          .readAsString();
      var email = await File('${appDocumentsDirectory.path}/activeUser.txt')
          .readAsString();
      print('token :-> $token');
      if (token != '') {
        auth_token = token;
        useremail = email;
        active_user = (await DatabaseHelper.instance.querySome(email))[0][DatabaseHelper.columnId];
        downloads = await DatabaseHelper.instance.queryAll('table$active_user');
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
    print('---login check completed---');
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


