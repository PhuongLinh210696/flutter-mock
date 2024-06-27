import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Mock/auth/login_register.dart';
import 'package:myapp/Mock/screen/getdbpath.dart';
import 'package:myapp/Mock/screen/province_screen.dart';

class AuthPage extends StatelessWidget {
  
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            
          }
          //user is logged in
          if(snapshot.hasData){
            return const ProvinceScreen();
            //return const MyWidget();
          }
          //user is not loggin
          else{
            return const LoginOrRegisPage();
          }
        },
      ),
    );
  }
}