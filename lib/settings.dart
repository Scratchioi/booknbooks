import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
      body: SingleChildScrollView(
        child: Center(
          child:Padding(
            padding: const EdgeInsets.all(20),
            child:
              Column(
  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(onPressed: (){
                    essentials().showToast('Logging out...');
                    auth_token = '';
                    // todo: delete or remove the token from the file
                    // todo: implement the auto-loading of the token at the time beginning
                    Navigator.pushReplacementNamed(context, '/auth');
                  },
                  child: Text('Logout',style: TextStyle(
                    color: Colors.white
                  ),)
                    ,color: Colors.red,)
                ],


              )
          )
        ),
      ),
    );
  }
}