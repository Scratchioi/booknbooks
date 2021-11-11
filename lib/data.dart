import 'package:booknbooks/apicalls.dart';
import 'package:flutter/material.dart';


Color primaryColor = Colors.orangeAccent;
Color secondaryColor = Colors.black54;


List<Widget> TabData = [
 Tab(text: 'Home', icon: Icon(Icons.home, color: primaryColor,),),
 Tab(text: 'Explore', icon: Icon(Icons.star, color: primaryColor,)),
 Tab(text: 'Settings', icon: Icon(Icons.settings, color: primaryColor))
];


String auth_token = '';

ApiCalls call_to_server = ApiCalls();


