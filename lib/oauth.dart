import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';


class authentication extends StatefulWidget {
  const authentication({Key? key}) : super(key: key);

  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  bool registered = true;
  TextEditingController _mail = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pasword = TextEditingController();

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
                     SizedBox(height: 20,),
                     TextField(
                       decoration: InputDecoration(
                         label: textData(info: 'Email', toBold: false, size: 24,),
                         hintText: 'Enter registered email address',
                         suffixIcon: Icon(Icons.supervisor_account),
                       ),
                     ),
                     SizedBox(height: 20,),
                     TextField(
                       decoration: InputDecoration(
                         label: textData(info:'Password', toBold: false,size:24,),
                         hintText: 'Enter password',

                         suffixIcon: Icon(Icons.lock),
                       ),
                     ),
                     SizedBox(height: 40,),
                     MaterialButton(onPressed: (){},child: Text('Login'),color: primaryColor,),
                     SizedBox(height: 20,),
                     textData(info: 'Not registered?', toBold: false, size: 16),
                     SizedBox(height: 10,),
                     MaterialButton(onPressed: (){
                       setState(() {
                         registered = false;
                       });
                     }, child: Text('Register'),color: primaryColor,)

                   ],
                 ),
               ),



               Visibility(visible: !registered,child: Column(
                 children: [
                   textData(info: 'Register', toBold: true, size: 24),
                   SizedBox(height: 20,),
                   TextField(
                     decoration: InputDecoration(
                       label: textData(info: 'Username', toBold: false, size: 24,),
                       hintText: 'Enter username',
                       suffixIcon: Icon(Icons.people),
                     ),
                   ),
                   SizedBox(height: 20,),
                   TextField(
                     decoration: InputDecoration(
                       label: textData(info: 'Email', toBold: false, size: 24,),
                       hintText: 'Enter email address',
                       suffixIcon: Icon(Icons.mail),
                     ),
                   ),
                   SizedBox(height: 20,),
                   TextField(
                     decoration: InputDecoration(
                       label: textData(info:'Password', toBold: false,size:24,),
                       hintText: 'Create a password (min 8 characters)',

                       suffixIcon: Icon(Icons.lock),
                     ),
                   ),
                   SizedBox(height: 40,),
                   MaterialButton(onPressed: (){},child: Text('Register'),color: primaryColor,),
                   SizedBox(height: 20,),
                   textData(info: 'Already a user?', toBold: false, size: 16),
                   SizedBox(height: 10,),
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
