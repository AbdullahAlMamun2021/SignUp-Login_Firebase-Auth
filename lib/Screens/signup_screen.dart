import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signup/Screens/home_screen.dart';
import 'package:login_signup/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isObscure=true;
  signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential =userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
      }
       else{
        Fluttertoast.showToast(msg:'Vai apni Registration koren nai');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "LogInSignUp Auth",
          style: TextStyle(color: deepPurpleColor),
        ),
        centerTitle: true,
        
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
             Image.asset(
                    'assets/images/order.jpg',
                    height: 300,
                    width: double.infinity),
             SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    onChanged: (text) {
                      // When user enter text in textfield getXHelper checktext method will get called
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        size: 25,
                        color: Colors.indigo,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.blue)),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    ),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    // onChanged: (text) {
                    //   // When user enter text in textfield getXHelper checktext method will get called
                    // },
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 25,
                        color: Colors.indigo,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
          
                      focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.blue)),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    ),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    obscureText: _isObscure,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscuringCharacter: '*',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),
                        color: Colors.indigo,
                        onPressed: () {
                          signUp();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
          
                        child: Text(
                          'SignUp',
                          style: TextStyle(fontSize: 25,color: Colors.white),
                        )),
                  ),
                ),
                  ],
                ),
          )),
    );
  }
}
