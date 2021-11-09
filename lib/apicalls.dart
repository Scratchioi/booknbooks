import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ApiCalls{
  String baseURL = 'http://192.168.1.10:8080';


   signup(String mail, String pwd1, String pwd2) async {
    Map data = {'email': mail,'password1':pwd1,'password2':pwd2};
    Response response = await post(Uri.parse(baseURL+'/rest-auth/registration/'),
        body: data);

    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    print(jsonDecode(response.body));
    return 'failed';
  }

   login(String email, String pwd)async{
    Response response = await post(
      Uri.parse(baseURL+'/rest-auth/login/'),
    body:{
        'email':email,
    'password':pwd
    }

    );

    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    return 'failed';
  }
  exploreData()async{
     Response response = await get(Uri.parse(baseURL+'/explore/'),
     headers: {'Authorization':'token 0d02046df4e85666deb3e6abe792b1e54176115d'});
     print(jsonDecode(response.body)); //debug print
  }
  searchData(String dataToSearch)async{

     Response response = await get(Uri.parse(baseURL+'/search?search=$dataToSearch'),

     headers: {'Authorization':'token 0d02046df4e85666deb3e6abe792b1e54176115d'},

     );
     print(jsonDecode(response.body)[0]['img_link']); //debug print
  }
  getToken()async{
     // getting token
  }

}