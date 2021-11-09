import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ApiCalls{
  String baseURL = 'http://192.168.1.10:8080';
  /*

  Response codes
   */
  String invalidToken = 'Invalid token.';

   signup(String mail, String pwd1, String pwd2) async {
    Map data = {'email': mail,'password1':pwd1,'password2':pwd2};
    Response response = await post(Uri.parse(baseURL+'/rest-auth/registration/'),
        body: data);

    if(response.statusCode==200){
      print(jsonDecode(response.body));
      essentials().showToast('Registration Successful');
    }
    print(jsonDecode(response.body));
    essentials().showToast('Registration Failed');
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
      essentials().showToast('Logged in Successful');
      // recieve token and store in a file

    }
    essentials().showToast('Login Failed');
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
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/token.txt';
    File file = File(filePath);
    // if(file.exists())
    //   {
    //     return file.readAsString();
    // }
    // else{
    //   return -1;
    // }

  }
  saveToken(String token)async{
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/token.txt';
    File file = File(filePath);
    file.writeAsString(token);

  }

}