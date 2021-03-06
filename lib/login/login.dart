import 'package:flutter/material.dart';
import 'package:AchaFacil/home/home_screen.dart';
import '../constants.dart';
import 'login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(mainTitleApp),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            },
          )),
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 40, right: 40),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          SizedBox(
            width: 128,
            height: 128,
            child: Image.asset("assets/icons/logo.png"),
          ),
          SizedBox(
            height: 20,
          ),
          LoginForm(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
