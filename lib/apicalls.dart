import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:booknbooks/data.dart';
import 'package:booknbooks/db.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ApiCalls{
  String baseURL = 'http://192.168.1.2:8080';
  // String baseURL = 'http://192.168.18.9:4454';

  /*

  Response codes
   */
  String invalidToken = 'Invalid token.';




   signup(String mail, String pwd1, String pwd2, BuildContext context) async {
    Map data = {'email': mail,'password1':pwd1,'password2':pwd2};
    Response response = await post(Uri.parse(baseURL+'/rest-auth/registration/'),
        body: data);
    print(response.statusCode);
    if(response.statusCode==200){
      print(jsonDecode(response.body));
      essentials().showToast('Registration Successful');
      return Navigator.pushReplacementNamed(context, '/auth');
    }
      else {
      essentials().showToast('Registration Failed');
    }
  }

   login(String email, String pwd, BuildContext context)async{
    Response response = await post(
      Uri.parse(baseURL+'/rest-auth/login/'),
    body:{
    'email':email,
    'password':pwd
    }

    );
    print(response.statusCode); // debug print
    print(jsonDecode(response.body));
    print(jsonDecode(response.body)['key']);
    auth_token = jsonDecode(response.body)['key'];
    // active_user = email;
    if(response.statusCode>=200 && response.statusCode<300){
      essentials().showToast('Logged in Successfully');
      useremail = email;

      List usertable = await DatabaseHelper.instance.querySome(email);
      if(usertable.isNotEmpty){
        // read the file and store the data
        active_user = usertable[0][DatabaseHelper.columnId];
        print('userId -> $active_user');
        downloads = await DatabaseHelper.instance.queryAll('table$active_user');
      }
      else{
        // todo: proper active_user, create the table
        var row = <String, dynamic>{
          DatabaseHelper.columnEmail: email,
          DatabaseHelper.columnName: ''
        };
        active_user = await DatabaseHelper.instance.insert(row, DatabaseHelper.tableName);
        await DatabaseHelper.instance.createDownloadTable('table$active_user');
      }
      saveToken(auth_token);
      print('inside');
      return Navigator.popAndPushNamed(context, '/home');
    }
    else{
      essentials().showToast('Login Failed: ${jsonDecode(response.body).toString()}');
    }
  }
  exploreData(BuildContext context)async{
     if(auth_token!=''){
       int num = Random().nextInt(300)+1;
       Response response = await get(Uri.parse(baseURL+'/explore/?page=$num'),
           headers: {'Authorization':'token $auth_token'});
       print(jsonDecode(response.body));//debug print
       data_explore = jsonDecode(response.body)['results'];
       print(data_explore);
       print('length of the data  : ${data_explore.length}');
     }
     else{
       print('return back to the login page');
       essentials().showToast('Session Expired');
       Navigator.pushReplacementNamed(context, '/auth');
     }
  }
  searchData(String dataToSearch, int gen)async{
    int num = Random().nextInt(8)+1;
     if(auth_token!=''){

       // print(jsonDecode(response.body)); //debug print
       if(gen==0){
         Response response = await get(Uri.parse(baseURL+'/search?search=$dataToSearch'),
             headers: {'Authorization':'token $auth_token'});
       data_search = jsonDecode(response.body);
       }
       else if(gen==1){
         Response response = await get(Uri.parse(baseURL+'/search?search=$dataToSearch&page=$num'),
             headers: {'Authorization':'token $auth_token'});
         data_gen1 = jsonDecode(response.body)['results'];
       }
       else if(gen==2){
         Response response = await get(Uri.parse(baseURL+'/search?search=$dataToSearch&page=$num'),
             headers: {'Authorization':'token $auth_token'});
         data_gen2 = jsonDecode(response.body)['results'];
       }
       else if(gen==3){
         Response response = await get(Uri.parse(baseURL+'/search?search=$dataToSearch&page=$num'),
             headers: {'Authorization':'token $auth_token'});
         data_gen3 = jsonDecode(response.body)['results'];
       }
       else if(gen==4){
         Response response = await get(Uri.parse(baseURL+'/search?search=$dataToSearch&page=$num'),
             headers: {'Authorization':'token $auth_token'});
         data_gen4 = jsonDecode(response.body)['results'];
       }
       print(data_search);
     }
  }
  getToken(BuildContext context)async{
     // getting token
    if(auth_token!=''){
      return auth_token;
    }
    else{
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/token.txt';
      File file = File(filePath);

      if(file.exists()==true)
      {
        auth_token = await file.readAsString();
        print(auth_token);

      }
      else{
        print('authentication failed');
        print('sending back to login page');
        Navigator.pushReplacementNamed(context,'/auth');
      }
    }

  }
  requestData(String url)async{
     Response response = await get(Uri.parse(url), headers: {'Authorization':'token $auth_token'});
     data_search = jsonDecode(response.body);

  }
  saveToken(String token)async{
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = appDocumentsDirectory.path;

    File file = File('$filePath/token.txt');
    File file2 = File('$filePath/activeUser.txt');
    file.writeAsString(token);
    // user email
    file2.writeAsString((await DatabaseHelper.instance.getUser(active_user))[0]['email']);

  }

}