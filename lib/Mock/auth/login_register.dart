import 'package:flutter/material.dart';
import 'package:myapp/Mock/auth/login_page.dart';
import 'package:myapp/Mock/auth/register_page.dart';

class LoginOrRegisPage extends StatefulWidget {
  const LoginOrRegisPage({super.key});

  @override
  State<LoginOrRegisPage> createState() => _LoginOrRegisPageState();
}

class _LoginOrRegisPageState extends State<LoginOrRegisPage> {

  bool showLoginPage = true;

  //toogle login register
  void toogleLoginOrRegis(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPageMyNote(
        onTap: toogleLoginOrRegis,
      );
    }else{
      return RegisterMyNote(
        onTap: toogleLoginOrRegis,
      );
    }
  }
}