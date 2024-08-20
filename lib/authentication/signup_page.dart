
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firebaseauthservice.dart';
import 'formcontainer.dart';
import 'toast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key,});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  bool _isSigningUp=false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _usernamecontroller,
                hintText: "Username",
                ispasswordfield: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailcontroller,
                hintText: "Email",
                ispasswordfield: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordcontroller,
                hintText: "Password",
                ispasswordfield: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap:(){
                  _signUp();
                  
                } ,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                  child: Center(
                      child: _isSigningUp ? CircularProgressIndicator(color: Colors.white,) :Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
             
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already Have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {


    setState(() {
      _isSigningUp=true;
    });
    String Username = _usernamecontroller.text;
    String email = _emailcontroller.text;
    String password = _passwordcontroller.text;

    User? user = await _auth.signupWithEmailAndPassword(email, password);

    setState(() {
      _isSigningUp=false;
    });

    if (user != null) {
      showToast(message: "User is Successfully Created");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Some Error happened!");
    }
  }




  
}