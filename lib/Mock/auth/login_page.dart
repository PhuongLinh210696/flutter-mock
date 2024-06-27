import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Mock/components/button_login.dart';
import 'package:myapp/Mock/components/textfield.dart';
import 'package:myapp/Mock/services/auth_service.dart';

class LoginPageMyNote extends StatefulWidget {
  final Function()? onTap;
  const LoginPageMyNote({super.key,required this.onTap});

  @override
  State<LoginPageMyNote> createState() => _LoginPageMyNoteState();
}

class _LoginPageMyNoteState extends State<LoginPageMyNote> {
  final emailController = TextEditingController();
  final passworController = TextEditingController();

  void signIn() async {
    // Hiển thị dialog loading
    showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng dialog khi nhấn ra ngoài
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Thực hiện đăng nhập
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passworController.text);

      // Đóng dialog loading khi đăng nhập thành công
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (err) {
      // Đóng dialog loading khi có lỗi xảy ra
      if (mounted) {
        Navigator.pop(context);
      }
      // Hiển thị thông báo lỗi
        errorMessage(err.code);
      
    }
  }

  // Thông báo sai email
  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(message),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 100),
              //logo
              const Text(
                'Sign In here',
                style: TextStyle(
                    color: Color.fromRGBO(59, 72, 176, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.w900),
              ),

              const SizedBox(height: 10),

              //Welcome
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //username textfield
              MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),

              const SizedBox(
                height: 20,
              ),
              //password textfield
              MyTextfield(
                controller: passworController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(
                height: 15,
              ),
              //forgot password
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot your password',
                        style: TextStyle(
                            color: Color.fromRGBO(59, 72, 176, 1),
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  )),

              const SizedBox(height: 40),

              //sign in button
              ButtonLogin(
                onTap: signIn,
                stringButton: 'Sign In',
              ),

              const SizedBox(
                height: 30,
              ),
              //register
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                'Create new account',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
              ,

              const SizedBox(
                height: 50,
              ),

              const Text(
                'Or continute with',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 8,
              ),
              //google sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => AuthService().signInWithGoogle(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                      child: Image.asset(
                        'assets/images/logo/google_logo.png',
                        height: 20,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
        )));
  }
}
