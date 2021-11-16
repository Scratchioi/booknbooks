import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';

import 'apicalls.dart';


class authentication extends StatefulWidget {
  const authentication({Key? key}) : super(key: key);

  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  bool registered = true;
  TextEditingController _mail = TextEditingController();
  // TextEditingController _name = TextEditingController();
  TextEditingController _pasword = TextEditingController();
  TextEditingController _confirmpwd = TextEditingController();

  @override
  void initState() {
    // checkLogin();
  }

  checkLogin() async {
    await call_to_server.getToken(context);
    if (auth_token != '') {
      await call_to_server.exploreData(context);
      await call_to_server.searchData('horror', 1);
      await call_to_server.searchData('comedy', 2);
      await call_to_server.searchData('adventure', 3);
      await call_to_server.searchData('murder', 4);
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
         SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Visibility(
                 visible: registered,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     textData(info: 'Login', toBold: true, size: 24),
                     const SizedBox(height: 20,),
                     TextField(
                       controller: _mail,
                       decoration: InputDecoration(
                         fillColor: Colors.white,
                         label: textData(info: 'Email', toBold: false, size: 24,),
                         hintText: 'Enter registered email address',
                         suffixIcon: const Icon(Icons.supervisor_account, color: Colors.white,
                         ),
                       ),
                     ),
                     const SizedBox(height: 20,),
                     TextField(
                       controller: _pasword,
                       decoration: InputDecoration(
                         label: textData(info:'Password', toBold: false,size:24,),
                         hintText: 'Enter password',
                         suffixIcon: const Icon(Icons.lock, color: Colors.white),
                       ),
                     ),
                     const SizedBox(height: 40,),
                     MaterialButton(onPressed: (){
                       call_to_server.login(_mail.text, _pasword.text, context);
                       print('done');
                       // call_to_server.exploreData();
                       // call_to_server.searchData('spiritual');
                       // Navigator.pushReplacementNamed(context, '/home');
                     },child: const Text('Login'),color: primaryColor,),
                     const SizedBox(height: 20,),
                     textData(info: 'Not registered?', toBold: false, size: 16),
                     const SizedBox(height: 10,),
                     MaterialButton(onPressed: (){
                       setState(() {
                         registered = false;
                       });
                     }, child: const Text('Register'),color: primaryColor,)

                   ],
                 ),
               ),

               Visibility(visible: !registered,child: Column(
                 children: [
                   textData(info: 'Register', toBold: true, size: 24),

                   const SizedBox(height: 20,),
                   TextField(
                     controller: _mail,
                     decoration: InputDecoration(
                       focusColor: Colors.white,
                       label: textData(info: 'Email', toBold: false, size: 22,),
                       hintText: 'Enter email address',
                       suffixIcon: Icon(Icons.mail),
                     ),
                   ),
                   const SizedBox(height: 20,),
                   TextField(
                     controller: _pasword,
                     decoration: InputDecoration(
                       label: textData(info:'Password', toBold: false,size:22,),
                       hintText: 'Create a password (min 8 characters)',

                       suffixIcon: Icon(Icons.lock),
                     ),
                   ),
                   const SizedBox(height: 20,),
                   TextField(
                     controller: _confirmpwd,
                     decoration: InputDecoration(
                       label: textData(info:'Confirm Password', toBold: false,size:22,),
                       hintText: 'Re-enter your password',

                       suffixIcon: Icon(Icons.lock),
                     ),
                   ),
                   const SizedBox(height: 40,),
                   MaterialButton(onPressed: (){

                     call_to_server.signup(_mail.text,_pasword.text,_confirmpwd.text, context);
                   },child: Text('Register'),color: primaryColor,),
                   const SizedBox(height: 20,),
                   textData(info: 'Already a user?', toBold: false, size: 16),
                   const SizedBox(height: 10,),
                   MaterialButton(onPressed: (){
                     setState(() {
                       registered = true;
                     });
                   }, child: Text('Login'),color: primaryColor,)
                 ],
               ))
             ],
           ),
         )
        ),
      ),
    );
  }
}
