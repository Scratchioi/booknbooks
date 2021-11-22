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
int active_user = -1;

ApiCalls call_to_server = ApiCalls();

List data_explore = [];

dynamic data_search;

List data_gen1 = [];
List data_gen2 = [];
List data_gen3 = [];
List data_gen4 = [];


List downloads = [];
Map myReadingList = {};
String useremail = '';

String searchOption = '';


