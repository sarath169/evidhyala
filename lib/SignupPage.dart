import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_card/LoginPage.dart';
import 'package:mi_card/StreamPage.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firebaseAuth = FirebaseAuth.instance;
  String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
        children: [
          Center(
            child: Text(
              'User SignUp',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width*0.13,
                    child: Text('Email: ')
                ),
                Flexible(
                  child: TextField(
                    onChanged: (value){
                      email = value;
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width*0.13,
                    child: Text('Password: ')
                ),
                Flexible(
                  child: TextField(
                    onChanged: (value){
                      password = value;
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 140,
              child: GestureDetector(
                onTap: () async {
    //TODO: Signup functionality
    final newUser=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>StreamPage()));
    });

                },
                child: Card(
                  color: Colors.blue,
                  elevation: 10,
                  child: Center(
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
