import 'dart:io';

import 'package:booknbooks/data.dart';
import 'package:booknbooks/db.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String email = '';

  getUserData()async{
    email = (await DatabaseHelper.instance.getUser(active_user))[0][DatabaseHelper.columnEmail];
    print('email >> $email');
    setState(() {});
    // List userdata = await DatabaseHelper.instance.queryAll();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child:Padding(
            padding: const EdgeInsets.all(20),
            child:
              Column(
  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      textData(info: 'User email : ', toBold: false, size: 18),
                      textData(info: email, toBold: true, size: 24),
                    ],
                  ),
                  MaterialButton(onPressed: ()async{
                    essentials().showToast('Logging out...');
                    auth_token = '';
                    // todo: delete or remove the token from the file
                    // todo: implement the auto-loading of the token at the time beginning
                    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
                    await File('${appDocumentsDirectory.path}/token.txt').delete();
                    await File('${appDocumentsDirectory.path}/activeUser.txt').delete();
                    Navigator.pushReplacementNamed(context, '/auth');
                  },
                  child: Text('Logout',style: TextStyle(
                    color: Colors.white
                  ),)
                    ,color: Colors.red,),
                  MaterialButton(onPressed: ()async{
                    await DatabaseHelper.instance.dropTable('table$active_user');
                    await DatabaseHelper.instance.createDownloadTable('table$active_user');
                  },
                  child: Text('Delete All Books', style: TextStyle(
                    color: Colors.white
                  ),),
                  color: Colors.red,)
                ],


              )
          )
        ),
      ),
    );
  }
}
